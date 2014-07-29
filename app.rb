require 'sinatra'
require 'sinatra/reloader'

require "./bus_finder"

get '/' do
  redirect '/zagreb'
end

get '/zagreb' do
  @destination = "zagreb"
  @departure   = "samobor"
  @buses = BusFinder.execute
  erb :index
end

get '/samobor' do
  @destination = "samobor"
  @departure   = "zagreb"
  @buses = BusFinder.execute("--return")
  erb :index
end
