require 'sinatra'
require 'sinatra/reloader'
require "dalli"
require "rack-cache"
require "pry"

require "./lib/presenter"

get '/' do
  redirect '/za/zagreb'
end

get '/za/:destination' do
  @presenter = Presenter.new(params)

  erb :index
end
