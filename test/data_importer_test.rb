require "minitest/autorun"
require "pry"

require "./test/helper"

require "./lib/departure_extractor"
require "./lib/page"
require "./lib/database_populator"
require "./lib/database"
require "./lib/data_importer"

Database.load
Database.drop!

describe DataImporter do
  @page = Page.new(path: "data/original.html")
  @subject = DataImporter.new({
    page: @page,
    season: "zimski"
  })
  @subject.execute

  describe "zimski" do
    describe "for 'radni dan' and departures from samobor to zagreb" do
      describe "departure at 12:05" do
        it "is one" do
          DayType.radni.
            departures.where(is_return: false, time_in_seconds: Time.parse("12:05").seconds_since_midnight).count.must_equal 1
        end

        it "is of type 'novaki'" do
          DayType.radni.
            departures.where(is_return: false, time_in_seconds: Time.parse("12:05").seconds_since_midnight).first.route_type.must_equal RouteType.novaki
        end
      end
    end
  end
end
