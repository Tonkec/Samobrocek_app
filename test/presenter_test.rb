require "./test/helper"
require "./lib/presenter"

describe "zimski" do
  def find_departures
    Presenter.new(destination: "zagreb")
  end

  describe "presenter" do
    describe "when direction is zagreb" do
      describe "and it is Monday, 24-3-2014" do
        describe "and the time is 0:15" do
          before do 
            @date = "0:15 24-3-2014"
          end
          it "returns 3 buses" do
            with_time_set_to @date do
              find_departures.departures.values.compact.count.must_equal 3
            end
          end

          it "and the past bus is nil" do
            with_time_set_to @date do
              find_departures.departures[:past].must_equal nil
            end
          end

          it "and the previous bus is nil" do
            with_time_set_to @date do
              find_departures.departures[:previous].must_equal nil
            end
          end

          it "and the current bus is at 04:10" do
            with_time_set_to @date do
              find_departures.departures[:current].time.strftime("%H:%M").
                must_equal "04:10"
            end
          end

          it "and the next bus is at 04:40" do
            with_time_set_to @date do
              find_departures.departures[:next].time.strftime("%H:%M").
                must_equal "04:40"
            end
          end

          it "and the future bus is at 05:05" do
            with_time_set_to @date do
              find_departures.departures[:future].time.strftime("%H:%M").
                must_equal "05:05"
            end
          end
        end
      end
    end
  end
end
