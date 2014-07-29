require 'sinatra'
require 'sinatra/reloader'

require "./bus_finder"

get '/' do
  @destination = "Zagreb"
  @buses = BusFinder.execute
  erb :index
end
