require "minitest/autorun"
require "./bus_finder"
require "pry"

Database.load
unless Departure.count > 0
  require "./import_data"
  ImportData.execute
end

def with_time_set_to(date)
  Time.stub(:now, Time.parse(date)) do
    yield
  end
end

describe "bus finder" do
  describe "when direction is zagreb" do
    describe "and it is Monday, 24-3-2014" do
      describe "and the time is 13:00" do
        it "returns 3 buses" do
          with_time_set_to "13:00 24-3-2014" do
            BusFinder.execute.count.must_equal 3
          end
        end

        it "and the first bus is departing in 12:40" do
          with_time_set_to "13:00 24-3-2014" do
            BusFinder.execute.
              first.time.strftime("%H:%M").
              must_equal "12:40"
          end
        end

        it "and the second bus is departing in 13:10" do
          with_time_set_to "13:00 24-3-2014" do
            BusFinder.execute.
              second.time.strftime("%H:%M").
              must_equal "13:10"
          end
        end

        it "and the last bus is departing in 13:30" do
          with_time_set_to "13:00 24-3-2014" do
            BusFinder.execute.
              last.time.strftime("%H:%M").
              must_equal "13:30"
          end
        end
      end
    end
  end

  describe "when direction is samobor" do
    describe "and it is Monday, 24-3-2014" do
      describe "and the time is 18:00" do
        it "returns 3 buses" do
          with_time_set_to "18:00 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              count.must_equal 3
          end
        end

        it "and the first bus is departing in 18:00" do
          with_time_set_to "18:00 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              first.time.strftime("%H:%M").
              must_equal "18:00"
          end
        end

        it "and the second bus is departing in 18:25" do
          with_time_set_to "18:00 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              second.time.strftime("%H:%M").
              must_equal "18:25"
          end
        end

        it "and the last bus is departing in 18:50" do
          with_time_set_to "18:00 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              last.time.strftime("%H:%M").
              must_equal "18:50"
          end
        end
      end

      describe "and the time is 17:59" do
        # edge cases yo
        it "and the first bus is departing in 17:40" do
          with_time_set_to "17:59 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              first.time.strftime("%H:%M").
              must_equal "17:40"
          end
        end

        it "and the second bus is departing in 18:00" do
          with_time_set_to "17:59 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              second.time.strftime("%H:%M").
              must_equal "18:00"
          end
        end

        it "and the last bus is departing in 18:25" do
          with_time_set_to "17:59 24-3-2014" do
            BusFinder.
              execute(direction: Direction.samobor).
              last.time.strftime("%H:%M").
              must_equal "18:25"
          end
        end
      end
    end
  end
end
