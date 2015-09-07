require "./lib/departure_finder"

class Presenter
  ROUTES = {:zagreb  => :samobor,
            :samobor => :zagreb}

  attr_reader :destination, :origin,
    :departures,
    :day_type

  def initialize(params)
    @destination = params[:destination].to_sym
    @origin      = ROUTES.invert[@destination]

    finder_args = @destination == :samobor ? "--return" : nil

    departures = DepartureFinder.execute(finder_args)

    @day_type = DayType.now.title

    @departures = {
      past:     departures[0],
      previous: departures[1],
      current:  departures[2],
      next:     departures[3],
      future:   departures[4],
    }
  end

  def for_zagreb?
    @destination == :zagreb
  end

  def for_samobor?
    @destination == :samobor
  end
end
