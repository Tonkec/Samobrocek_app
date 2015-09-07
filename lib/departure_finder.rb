require "pry"
require "./lib/database"

Database.load

class DepartureFinder
  class DepartureNotFound < StandardError; end

  # Returns 3 departures, the last bus departed,
  # the next departing one and the one after that
  def self.execute(*args)
    new(*args).execute
  end

  def initialize(*args)
    opts = args.first || {}

    @is_return = args.first == '--return'
  end

  def execute
    args = {
      day_type: DayType.now,
      is_return: @is_return
    }

    {
      past: Departure.desc(:time_in_seconds).where(args.merge({
            :time_in_seconds.lt => minutes_since_midnight_in_seconds
            })).limit(2).reverse,
      future: Departure.asc(:time_in_seconds).where(args.merge({
              :time_in_seconds.gte => minutes_since_midnight_in_seconds
              })).limit(3),
    }
  end

  private

    def minutes_since_midnight_in_seconds
      (Time.now.in_time_zone.seconds_since_midnight / 60).to_i * 60
    end

    def range_hash
      {
        :last   => 0..Time.now.in_time_zone.seconds_since_midnight,
        :first  => 1.minute.from_now.
                     seconds_since_midnight..3600*24,
        :second => 1.minute.from_now.
                     seconds_since_midnight..3600*24
      }
    end

    def find_departures
      range_hash.map do |position, range|

        Departure.asc(:time_in_seconds).where(args).send(position) 
      end 
    end
end
