require 'sinatra'
require 'sinatra/reloader'

require "./bus_finder"

get '/' do
  redirect '/za/zagreb'
end

get '/za/zagreb' do
  @destination = "zagreb"
  @departure   = "samobor"
  @buses = BusFinder.execute
  @day_type = DayType.now.title

  erb :index
end

get '/za/samobor' do
  @destination = "samobor"
  @departure   = "zagreb"
  @buses = BusFinder.execute("--return")
  @day_type = DayType.now.title

  erb :index
end
