ENV["RACK_ENV"] ||= "test"

require "minitest/autorun"
require "nokogiri"
require "pry"

require "./fetch_data"

Database.load
Database.drop!
FetchData.execute('zimski')

class Nokogiri::XML::Element
  def normalized_text
    text.gsub(" ", "").gsub(/\b\W+\b/, " ").
      gsub(/\b\W+$/, "").downcase
  end

  def downcased_text
    text.tr('A-Z', 'a-z')
  end
end

def with_time_set_to(date)
  Time.stub(:now, Time.parse(date)) do
    yield
  end
end

class Time
  def self.minutes_since_midnight_in_seconds
    (Time.now.in_time_zone.seconds_since_midnight.to_i / 60) * 60
  end
end

def find_departures_for_zagreb
  DepartureFinder.execute
end

def find_departures_for_samobor
  DepartureFinder.execute("--return")
end
