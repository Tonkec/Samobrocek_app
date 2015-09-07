require "./test/helper"
require "./lib/departure_finder"

describe "holiday support" do
  describe "bus finder" do
    describe "when direction is zagreb" do
      describe "and the time is 13:00 on Christmas 2015" do
        before do
          @date = "13:10 25-12-2015"
        end

        it "sets day type to 'Sunday'" do
          with_time_set_to @date do
            find_departures_for_zagreb[:future].last.day_type.must_equal DayType.sunday
          end
        end
      end
    end
  end
end
