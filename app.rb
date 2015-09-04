require 'sinatra'
require 'sinatra/reloader'
require "dalli"
require "rack-cache"
require "pry"

require "./departure_finder"

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
      previous: departures[0],
      current:  departures[1],
      next:     departures[2],
    }
  end

  def for_zagreb?
    @destination == :zagreb
  end

  def for_samobor?
    @destination == :samobor
  end
end

get '/' do
  redirect '/za/zagreb'
end

get '/za/:destination' do
  @presenter = Presenter.new(params)

  erb :index
end
