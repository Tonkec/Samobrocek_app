require 'active_support/all'
Time.zone = 'Europe/Zagreb'

require './app'
run Sinatra::Application
