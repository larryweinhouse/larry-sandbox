module Loaders
  class TelemetryLoader < BaseLoader
    GMAIL_LABEL = 'Telemetry'
    
    def standardize_row(r)
      unless r.length < 6
        stat = Telemetry.new
        stat.partner             = r[0]
        stat.outpost_application = r[1]
        stat.group_id            = r[2]
        stat.requests            = r[3].to_i
        stat.hits                = r[4].to_i
        stat.date                = r[5]

        return stat
      end
    end

  end
end
