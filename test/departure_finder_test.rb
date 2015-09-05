require "./test/helper"
require "./departure_finder"

def previous_bus_for_zagreb
  find_departures_for_zagreb[1]
end

def current_bus_for_zagreb
  find_departures_for_zagreb[2]
end

def next_bus_for_zagreb
  find_departures_for_zagreb[3]
end

def previous_bus_for_samobor
  find_departures_for_samobor[1]
end

def current_bus_for_samobor
  find_departures_for_samobor[2]
end

def next_bus_for_samobor
  find_departures_for_samobor[3]
end

describe "zimski" do
  describe "bus finder" do
    describe "when direction is zagreb" do
      describe "and it is Monday, 24-3-2014" do
        describe "and the time is 13:00" do
          before do 
            @date = "13:00 24-3-2014"
          end
          it "returns 3 buses" do
            with_time_set_to @date do
              find_departures_for_zagreb.count.must_equal 5
            end
          end

          it "and the previous bus is departing at 12:40" do
            with_time_set_to @date do
              previous_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "12:40"
            end
          end

          it "and the current bus is departing at 13:10" do
            with_time_set_to @date do
              current_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "13:10"
            end
          end

          it "and the next bus is departing at 13:30" do
            with_time_set_to @date do
              next_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "13:30"
            end
          end
        end

        describe "and the time is 11:30" do
          before do 
            @date = "11:30 24-3-2014"
          end
          it "returns 3 buses" do
            with_time_set_to @date do
              find_departures_for_zagreb.count.must_equal 5
            end
          end

          it "and the previous bus is departing at 11:10" do
            with_time_set_to @date do
              previous_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "11:20"
            end
          end

          it "and the current bus is departing at 11:40" do
            with_time_set_to @date do
              current_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "11:40"
            end
          end

          it "and the next bus is departing at 12:05" do
            with_time_set_to @date do
              next_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "12:05"
            end
          end

          it "and the next bus is 'Tour de Novaki'" do
            with_time_set_to @date do
              bus = find_departures_for_zagreb.
                last

              bus.route_type.must_equal RouteType.novaki
            end
          end
        end
      end
    end

    describe "when direction is samobor" do
      describe "and it is Saturday, 22-3-2014" do
        describe "and the time is 23:46" do
          before do
            @time = "23:46 22-3-2014" # the last bus is gone
          end

          it "returns only previous buses" do
            with_time_set_to @time do
              find_departures_for_samobor.map {|departure| departure.time.strftime("%H:%M") }.
                must_equal ["23:05", "23:45"]
            end
          end
        end

        describe "and the time is 00:15" do
          before do
            @time = "00:15 22-3-2014" # the last bus is gone
          end

          it "returns only future buses" do
            with_time_set_to @time do
              find_departures_for_samobor.map {|departure| departure.time.strftime("%H:%M") }.
                must_equal ["05:00", "05:40", "06:00"]
            end
          end
        end
      end

      describe "and it is Monday, 24-3-2014" do
        describe "and the time is 18:00" do
          it "returns 3 buses" do
            with_time_set_to "18:00 24-3-2014" do
              find_departures_for_samobor.count.must_equal 5
            end
          end

          it "and the previous bus is departing at 18:00" do
            with_time_set_to "18:00 24-3-2014" do
              previous_bus_for_zagreb.
                time.strftime("%H:%M").
                must_equal "17:20"
            end
          end

          it "and the current bus is departing at 18:25" do
            with_time_set_to "18:00 24-3-2014" do
              current_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "18:00"
            end
          end

          it "and the next bus is departing at 18:50" do
            with_time_set_to "18:00 24-3-2014" do
              next_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "18:25"
            end
          end

          it "seconds don't matter" do
            with_time_set_to "18:00:59 24-3-2014" do
              current_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "18:00"
            end
          end
        end

        describe "and the time is 17:59:59" do
          before do
            @time = "17:59:59 24-3-2014"
          end

          it "and the previous bus is departing at 17:40" do
            with_time_set_to @time do
              previous_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "17:40"
            end
          end

          it "and the current bus is departing at 18:00" do
            with_time_set_to @time do
              current_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "18:00"
            end
          end

          it "and the next bus is departing at 18:25" do
            with_time_set_to @time do
              next_bus_for_samobor.
                time.strftime("%H:%M").
                must_equal "18:25"
            end
          end
        end
      end
    end
  end
end

describe "ljetni" do
  it "is not implemented"
end
