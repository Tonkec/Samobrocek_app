class Chunk
  def self.fetch(opts)
    validate! opts

    all_departures = opts[:page].get_chunk opts[:position]
    departures_novaki = opts[:page].get_chunk(opts[:position] + 2)
    departures_kerestinec = opts[:page].get_chunk(opts[:position] + 4)

    departures = all_departures -
      departures_novaki - departures_kerestinec

    populate_database({
      direct: departures,
      novaki: departures_novaki,
      kerestinec: departures_kerestinec
    }, opts)
  end

  private

    def self.validate!(opts)
      return if opts[:position] && opts[:line] &&
        opts[:direction]

      raise ArgumentError
    end

    def self.populate_database(departures, opts)
      departures.each do |key, times|
        times.each do |time|
          next unless time =~ /\d/
          Departure.create(
            time: Time.parse(time).seconds_since_midnight,
            line_id: opts[:line].id,
            direction_id: opts[:direction].id,
            route_type_id: RouteType.send(key).id,
            day_type: opts[:day_type].id,
            starred: (time =~ /\*/) != nil
          )
        end
      end
    end
end
