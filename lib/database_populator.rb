class InvalidTimeFormat < StandardError; end
class DatabasePopulator
  def self.execute(opts)
    direct = opts[:departures][:all] -
      opts[:departures][:novaki] - opts[:departures][:kerestinec]

    populate_database({
      direct: direct,
      novaki: opts[:departures][:novaki],
      kerestinec: opts[:departures][:kerestinec]
    }, opts)
  end

  private

    def self.populate_database(departures, opts)
      departures.each do |key, times|
        times.each do |time|
          time.tr!('.,', ':')

          if time !~ /^\*{,2}\d{1,2}:\d{2}$/
            raise InvalidTimeFormat.new("Invalid time format: #{time.inspect}")
          end

          Departure.create(
            time: Time.parse(time).seconds_since_midnight,
            line_id: Line.first.id,
            is_return: opts[:is_return],
            route_type_id: RouteType.send(key).id,
            day_type_id: opts[:day_type].id,
            starred: (time =~ /\*/) != nil
          )
        end
      end
    end
end
