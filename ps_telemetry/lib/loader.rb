module PSTelemetry
  class Loader

    DB_CONFIG = YAML::load(IO.read("#{BASE_PATH}/config/database.yml"))[ENV['ENV']]
    ActiveRecord::Base.establish_connection(DB_CONFIG)

    def initialize(opts={})
      @opts = opts
      @gmail_client = get_gmail_client!  
    end

    def get_gmail_client!
      begin
        Gmail.connect!(@opts[:gmail_username], @opts[:gmail_password])
      rescue StandardError=>e
        abort "Exception connecting to gmail: #{e.message}"
      end
    end

    def run
      @opts[:loaders].each do |l|
        warn "Running loader: #{l}"
        ::Loaders.const_get(l).new(gmail_client: @gmail_client, mysql_client: @mysql_client).load!
        warn "Done with: #{l}"
      end
    end

  end
end
