require 'sinatra'
require 'sinatra/reloader'

require "./bus_finder"

get '/' do
  @buses = BusFinder.execute
  erb :index
end
