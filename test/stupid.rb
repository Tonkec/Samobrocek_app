# a very stupid test
#
require "minitest/autorun"

require "./lib/database"

Database.load

describe "zimski" do
  before do
    unless Departure.count > 0
      require "./import_data"
      ImportData.execute('zimski')
    end
  end

  describe "data importer for line id=18" do
    it "imports exactly 259 departures" do
      Departure.count.must_equal 259
    end

    describe "when direction is zagreb" do
      describe "and route type is 'kerestinec'" do
        describe "and day type is 'radni dan'" do
          it "imports 4 departures" do
            Departure.where(:is_return => false,
                            :route_type => RouteType.kerestinec,
                            :day_type => DayType.radni)
            .count.must_equal 4
          end
        end

        describe "and day type is 'subota'" do
          it "imports 9 departures" do
            Departure.where(:is_return => false,
                            :route_type => RouteType.kerestinec,
                            :day_type => DayType.subota)
            .count.must_equal 9
          end
        end

        describe "and day type is 'nedjelja'" do
          it "imports 5 departures" do
            Departure.where(:is_return => false,
                            :route_type => RouteType.kerestinec,
                            :day_type => DayType.nedjelja)
            .count.must_equal 5
          end
        end

      end
    end

    describe "importing first departure" do
      before do
        @it = Departure.order_by(:created_at => 'asc').first
      end

      it "has correct time" do
        @it.time.strftime("%H:%M").must_equal "04:10"
      end

      it "has correct route type" do
        @it.route_type.must_equal RouteType.direct
      end

      it "has correct day type" do
        @it.day_type.must_equal DayType.radni
      end

      it "has correct line" do
        @it.line.must_equal Line.first
      end
    end

    describe "importing last departure" do
      before do
        @it = Departure.order_by(:created_at => 'desc').first
      end

      it "has correct time" do
        @it.time.strftime("%H:%M").must_equal "23:00"
      end

      it "has correct route type" do
        @it.route_type.must_equal RouteType.kerestinec
      end

      it "has correct day type" do
        @it.day_type.must_equal DayType.nedjelja
      end

      it "has correct line" do
        @it.line.must_equal Line.first
      end
    end
  end
end

describe "ljetni" do
  it "is not implemented"
end
