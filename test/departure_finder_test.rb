require "./test/helper"
require "./departure_finder"

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
              find_departures_for_zagreb.count.must_equal 3
            end
          end

          it "and the first bus is departing at 12:40" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                first.time.strftime("%H:%M").
                must_equal "12:40"
            end
          end

          it "and the second bus is departing at 13:10" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                second.time.strftime("%H:%M").
                must_equal "13:10"
            end
          end

          it "and the last bus is departing at 13:30" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                last.time.strftime("%H:%M").
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
              find_departures_for_zagreb.count.must_equal 3
            end
          end

          it "and the first bus is departing at 11:10" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                first.time.strftime("%H:%M").
                must_equal "11:20"
            end
          end

          it "and the second bus is departing at 11:40" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                second.time.strftime("%H:%M").
                must_equal "11:40"
            end
          end

          it "and the last bus is departing at 12:05" do
            with_time_set_to @date do
              find_departures_for_zagreb.
                last.time.strftime("%H:%M").
                must_equal "12:05"
            end
          end

          it "and the last bus is 'Tour de Novaki'" do
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
        describe "and the time is 23:30" do
          it "returns 3 buses"
          it "last bus returned is the first bus from the next day"
        end
      end

      describe "and it is Monday, 24-3-2014" do
        describe "and the time is 18:00" do
          it "returns 3 buses" do
            with_time_set_to "18:00 24-3-2014" do
              find_departures_for_samobor.count.must_equal 3
            end
          end

          it "and the first bus is departing at 18:00" do
            with_time_set_to "18:00 24-3-2014" do
              find_departures_for_samobor.
                first.time.strftime("%H:%M").
                must_equal "18:00"
            end
          end

          it "and the second bus is departing at 18:25" do
            with_time_set_to "18:00 24-3-2014" do
              find_departures_for_samobor.
                second.time.strftime("%H:%M").
                must_equal "18:25"
            end
          end

          it "and the last bus is departing at 18:50" do
            with_time_set_to "18:00 24-3-2014" do
              find_departures_for_samobor.
                last.time.strftime("%H:%M").
                must_equal "18:50"
            end
          end
        end

        describe "and the time is 17:59" do
          # edge cases
          it "and the first bus is departing at 17:40" do
            with_time_set_to "17:59 24-3-2014" do
              find_departures_for_samobor.
                first.time.strftime("%H:%M").
                must_equal "17:40"
            end
          end

          it "and the second bus is departing at 18:00" do
            with_time_set_to "17:59 24-3-2014" do
              find_departures_for_samobor.
                second.time.strftime("%H:%M").
                must_equal "18:00"
            end
          end

          it "and the last bus is departing at 18:25" do
            with_time_set_to "17:59 24-3-2014" do
              find_departures_for_samobor.
                last.time.strftime("%H:%M").
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
