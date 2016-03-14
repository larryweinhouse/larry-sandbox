module Loaders
  class BaseLoader

    def initialize(opts={})
      @opts = opts
    end

    def load!
      gmail_client.mailbox(self.class::GMAIL_LABEL).find(:unread).each do |e|
        log = LoadLog.new(loader: self.class.name, email_date: e.envelope.date)
        e.message.attachments.each do |a|
          begin
            save_file(a)
          rescue StandardError => err
            warn "Failed to save attachment #{err}"
            # send email here.
          end
          get_parser(a).each do |row|
            if stat = standardize_row(row)
              begin
                stat.save!
                log.new_lines+=1
              rescue ActiveRecord::RecordNotUnique
                log.duplicate_lines+=1 # Already loaded skipping
              rescue StandardError => err
                log.line_errors+=1
                warn "Failed to insert/update record #{stat.attributes.inspect} with error: #{err.message}"
              end
            end
          end
          log.attachments+=1
        end
        log.save!
        e.read!
      end
      
    end

    protected
    def gmail_client
       @opts[:gmail_client]
    end

    def get_parser(att)
      file = att.decoded
      file_arr = file.split(/\n/).map { |m| m }
      file_arr.map { |l| l.split(/\t/) }
    end

    def save_file(att)
      folder = '/share/proximity/telemetry' 
      File.write(File.join(folder, att.filename), att.body.decoded)
      rename_file(folder, att.filename)
    end

    def rename_file(folder, file_name)
      myset = Array.new
      File.readlines("#{folder}/#{file_name}").each do |l|
        line = l.chomp.split(/\t/)
        myset.push(line[5]) unless line.length < 6
      end
      unique_set = myset.to_set
      if unique_set.length == 1
        f_name = file_name.gsub(/.csv$/, '')
        File.rename("#{folder}/#{file_name}", "#{folder}/#{f_name}.#{unique_set.to_a[0]}.csv")
      else
        f_name = file_name.gsub(/.csv$/, '')
        f_id = UUIDTools::UUID.random_create
        File.rename("#{folder}/#{file_name}", "#{folder}/#{f_name}.#{f_id}.err")
        raise "multiple dates in telemetry file: #{f_name}.#{f_id}.err: #{unique_set.to_a}"
      end
    end
    
  end
end
