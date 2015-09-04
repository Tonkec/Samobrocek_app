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
    find_departures
  end

  private

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
        args = {
          time_in_seconds: range,
          day_type: DayType.now,
          is_return: @is_return
        }

        Departure.asc(:time_in_seconds).where(args).send(position) 
      end 
    end
end
