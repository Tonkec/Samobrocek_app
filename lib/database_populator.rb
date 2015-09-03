require 'awesome_print'

class InvalidTimeFormat < StandardError; end
class DatabasePopulator
  def self.execute(opts)
    all        = opts[:departures][:all]
    novaki     = opts[:departures][:novaki]
    kerestinec = opts[:departures][:kerestinec]

    direct = all.select do |t|
      time = t.gsub(/.*(\d{2}:\d{2})/, '\1')
      result = novaki.grep(/#{Regexp.quote(time)}/).empty? && 
        kerestinec.grep(/#{Regexp.quote(time)}/).empty?
    end

    populate_database({
      direct: direct,
      novaki: novaki,
      kerestinec: kerestinec
    }, opts)
  end

  private

    def self.populate_database(departures, opts)
      if  opts[:verbose]
        ap departures
      end

      departures.each do |key, times|
        times.each do |time|
          if time !~ /^\*{,1}\d{1,2}:\d{2}$/
            if opts[:verbose]
              puts InvalidTimeFormat.new("Skipping: #{time.inspect}")
            end
            next
          end


          time_in_seconds = Time.parse(time).seconds_since_midnight.floor

          Departure.create!(
            time_in_seconds: time_in_seconds,
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
