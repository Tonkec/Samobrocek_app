require "./models/day_type"
require "./models/line"
require "./models/departure"
require "./models/route_type"

class Database
  def self.load(env = ENV["RACK_ENV"])
    load_mongoid(env || "development")
  end

  def self.drop!
    Mongoid.purge!
  end

  private

    def self.load_mongoid(env)
      Mongoid.load!("mongoid.yml", env)
    end
end
