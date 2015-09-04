require 'active_support/all'
Time.zone = 'Europe/Zagreb'

require './app'


if ENV["MEMCACHED_1_PORT_11211_TCP_ADDR"]
  memcache_url = "#{ENV["MEMCACHED_1_PORT_11211_TCP_ADDR"]}:#{ENV["MEMCACHED_1_PORT_11211_TCP_PORT"]}"
  client = Dalli::Client.new(memcache_url, password: "password", username: "admin")
  use Rack::Cache,
    verbose: true,
    metastore: client,
  entitystore: client
end

run Sinatra::Application
