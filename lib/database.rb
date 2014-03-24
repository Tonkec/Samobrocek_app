class Database
  def self.prepare!
    load_mongoid
    drop!
  end

  private

    def self.load_mongoid
      Mongoid.load!("mongoid.yml", :development)
    end

    def self.drop! # the base WOW WOW WOOOOW
      Line.destroy_all
      DayType.destroy_all
      Direction.destroy_all
      Departure.destroy_all
      RouteType.destroy_all
    end
end
