require 'sinatra'
require 'sinatra/reloader'

require "./bus_finder"

class Presenter
  ROUTES = {:zagreb  => :samobor,
            :samobor => :zagreb}

  attr_reader :destination, :departure,
    :future_departures, :last_departure,
    :day_type

  def initialize(params)
    @destination = params[:destination].to_sym
    @departure   = ROUTES.invert[@destination]

    finder_args = @destination == :samobor ? "--return" : nil
    
    buses = BusFinder.execute(finder_args)
    
    @future_departures = buses[1..-1]
    @last_departure    = buses.first
    @dayType = DayType.now.title
  end
end

get '/' do
  redirect '/za/zagreb'
end

get '/za/:destination' do
  @presenter = Presenter.new(params)

  erb :index
end
