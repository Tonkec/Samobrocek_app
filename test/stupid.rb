# a very stupid test
#
require "minitest/autorun"
require "./import_data"

ImportData.execute

describe "data importer for line id=18" do
  describe "when direction is zagreb" do
    describe "and route type is 'kerestinec'" do
      describe "and day type is 'radni dan'" do
        it "imports 4 departures" do
          Departure.where(:direction => Direction.zagreb,
                          :route_type => RouteType.kerestinec,
                          :day_type => DayType.radni)
          .count.must_equal 4
        end
      end

      describe "and day type is 'subota'" do
        it "imports 9 departures" do
          Departure.where(:direction => Direction.zagreb,
                          :route_type => RouteType.kerestinec,
                          :day_type => DayType.subota)
          .count.must_equal 9
        end
      end

      describe "and day type is 'nedjelja'" do
        it "imports 5 departures" do
          Departure.where(:direction => Direction.zagreb,
                          :route_type => RouteType.kerestinec,
                          :day_type => DayType.nedjelja)
          .count.must_equal 5
        end
      end

    end
  end

  describe "importing first departure" do
    before do
      @it = Departure.first
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

    it "has correct direction" do
      @it.direction.must_equal Direction.zagreb
    end

    it "has correct line" do
      @it.line.must_equal Line.first
    end
  end

  describe "importing last departure" do
    before do
      @it = Departure.last
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

    it "has correct direction" do
      @it.direction.must_equal Direction.samobor
    end

    it "has correct line" do
      @it.line.must_equal Line.first
    end
  end
end
