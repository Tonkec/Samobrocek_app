require "pry"
require "./lib/database"

Database.load

class DepartureFinder
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
    find_departures.tap do |dep|
      dep.each {|d| puts d.time.strftime("%H:%M") }
    end
  end

  private

    def range_hash
      {
        :last   => 0..Time.now.seconds_since_midnight,
        :first  => 1.minute.from_now.
                     seconds_since_midnight..3600*24,
        :second => 1.minute.from_now.
                     seconds_since_midnight..3600*24
      }
    end

    def find_departures
      range_hash.map do |position, range|
        Departure.asc(:time).where(
          time: range,
          day_type: DayType.now,
          is_return: @is_return
        ).send(position)
      end.select {|d| d}
    end
end
