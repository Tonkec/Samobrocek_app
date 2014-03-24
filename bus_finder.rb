require "pry"
require "./lib/database"

Database.load

class BusFinder
  # Returns 3 buses, the last bus departed,
  # the next departing one and the one after that
  def self.execute(*args)
    new(*args).execute
  end

  def initialize(*args)
    opts = args.first || {}
    
    @direction = opts[:direction] || Direction.zagreb
  end

  def execute
    {
      :last   => 0..Time.now.seconds_since_midnight,
      :first  => Time.now.seconds_since_midnight..3600*24,
      :second => Time.now.seconds_since_midnight..3600*24
    }.map do |position, range|

      Departure.asc(:time).where(
      time: range,
      day_type: DayType.now,
      direction: @direction).send(position)

    end
  end
end
