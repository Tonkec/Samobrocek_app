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
      past:     departures[:past][0],
      previous: departures[:past][1],
      current:  departures[:future][0],
      next:     departures[:future][1],
      future:   departures[:future][2],
    }
  end

  def for_zagreb?
    @destination == :zagreb
  end

  def for_samobor?
    @destination == :samobor
  end
end
