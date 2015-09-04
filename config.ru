require 'active_support/all'
Time.zone = 'Europe/Zagreb'

require './app'


if ENV["MEMCACHED_PORT_11211_TCP_ADDR"]
  memcache_url = "#{ENV["MEMCACHED_PORT_11211_TCP_ADDR"]}:#{ENV["ZUCKO_DB_1_PORT_27017_TCP_PORT"]}"
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_url}",
  entitystore: "memcached://#{memcache_url}"
end

run Sinatra::Application
