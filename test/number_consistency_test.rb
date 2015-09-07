require "./test/helper"
require "./lib/presenter"

describe "zimski" do
  describe "and day is weekday" do
    describe "when direction is zagreb" do
      it "'kerestinec' count is 4" do
        Departure.where(day_type: DayType.weekday,
                        is_return: false,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 4
      end

      it "'novaki' count is 19" do
        Departure.where(day_type: DayType.weekday,
                        is_return: false,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 19
      end
    end

    describe "when direction is samobor" do
      it "'kerestinec' count is 4" do
        Departure.where(day_type: DayType.weekday,
                        is_return: true,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 4
      end

      it "'novaki' count is 19" do
        Departure.where(day_type: DayType.weekday,
                        is_return: true,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 21
      end
    end
  end

  describe "and day is saturday" do
    describe "when direction is zagreb" do
      it "'kerestinec' count is 9" do
        Departure.where(day_type: DayType.saturday,
                        is_return: false,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 9
      end

      it "'novaki' count is 17" do
        Departure.where(day_type: DayType.saturday,
                        is_return: false,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 17
      end
    end

    describe "when direction is samobor" do
      it "'kerestinec' count is 10" do
        Departure.where(day_type: DayType.saturday,
                        is_return: true,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 10
      end

      it "'novaki' count is 15" do
        Departure.where(day_type: DayType.saturday,
                        is_return: true,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 15
      end
    end
  end
  
  describe "and day is sunday" do
    describe "when direction is zagreb" do
      it "'kerestinec' count is 4" do
        Departure.where(day_type: DayType.sunday,
                        is_return: false,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 5
      end

      it "'novaki' count is 15" do
        Departure.where(day_type: DayType.sunday,
                        is_return: false,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 15
      end
    end

    describe "when direction is samobor" do
      it "'kerestinec' count is 6" do
        Departure.where(day_type: DayType.sunday,
                        is_return: true,
                        route_type: RouteType.kerestinec).
                        count.
                        must_equal 6
      end

      it "'novaki' count is 14" do
        Departure.where(day_type: DayType.sunday,
                        is_return: true,
                        route_type: RouteType.novaki).
                        count.
                        must_equal 14
      end
    end
  end
end
