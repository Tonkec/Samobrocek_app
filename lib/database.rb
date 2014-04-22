require "./models/day_type"
require "./models/line"
require "./models/direction"
require "./models/departure"
require "./models/route_type"

class Database
  def self.load(env = :development)
    load_mongoid(env)
  end

  def self.drop! # the base WOW WOW WOOOOW
    Line.destroy_all
    DayType.destroy_all
    Direction.destroy_all
    Departure.destroy_all
    RouteType.destroy_all
  end

  private

    def self.load_mongoid(env)
      Mongoid.load!("mongoid.yml", env)
    end
end
