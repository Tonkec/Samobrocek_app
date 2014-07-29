require 'sinatra'
require 'sinatra/reloader'

require "./departure_finder"

class Presenter
  ROUTES = {:zagreb  => :samobor,
            :samobor => :zagreb}

  attr_reader :destination, :origin,
    :future_departures, :last_departure,
    :day_type

  def initialize(params)
    @destination = params[:destination].to_sym
    @origin      = ROUTES.invert[@destination]

    finder_args = @destination == :samobor ? "--return" : nil
    
    departures = DepartureFinder.execute(finder_args)
    
    @future_departures = departures[1..-1]
    @last_departure    = departures.first
    @day_type = DayType.now.title
  end
end

get '/' do
  redirect '/za/zagreb'
end

get '/za/:destination' do
  @presenter = Presenter.new(params)

  erb :index
end
