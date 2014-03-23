require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "pry"

require "./models/day_type"
require "./models/line"
require "./models/direction"
require "./models/departure"
require "./models/route_type"

Mongoid.load!("mongoid.yml", :development)

Line.destroy_all
DayType.destroy_all
Direction.destroy_all
Departure.destroy_all
RouteType.destroy_all

XPATH_TARGET = page.xpath("//tbody//p")
POSITION = {
  :line_name => 3,
  :day_types => [5, 21, 36],
  :directions => [6, 13],
  :route_types => [8, 10]
}
URL = "http://www.samoborcek.hr/linija.php?id=18" 

puts "Fetching data..."
page = Nokogiri::HTML(open(URL))
puts "Success!"

def get_title(position)
  Array(position).map do |position|
    normalize_raw_titles XPATH_TARGET[position].text
  end
end

def get_chunk(position)
  Array(position).map do |position|
    XPATH_TARGET[position].text.split(" ").map do |el|
      el.gsub(/\W+$/, "").gsub(/(,|\.)/, ":")
    end
  end.flatten
end

def normalize_raw_titles(raw)
  raw.gsub(" ", "").gsub(/\b\W+\b/, " ").
    gsub(/\b\W+$/, "").downcase
end

line_name  = get_title(POSITION[:line_name]).first
day_types  = get_title(POSITION[:day_types])
directions = get_title(POSITION[:directions])
types      = get_title(POSITION[:route_types])

line       = Line.create(title: line_name)
day_types  = day_types.map {|t| DayType.create(title: t)}
directions = directions.map {|t| Direction.create(title: t)}
types      =  types.map {|t| RouteType.create(title: t)}
types      << RouteType.create(title: "direct")

class Chunk
  def self.populate_database(departures, opts)
    departures.each do |key, times|
      times.each do |time|
        next unless time =~ /\d/
        Departure.create(
          time: Time.parse(time),
          line_id: opts[:line].id,
          direction_id: opts[:direction].id,
          route_type_id: RouteType.send(key).id,
          day_type: opts[:day_type].id,
          starred: (time =~ /\*/) != nil
        )
      end
    end
  end

  def self.fetch(opts)
    validate! opts

    all_departures = get_chunk opts[:position]
    departures_novaki = get_chunk(opts[:position] + 2)
    departures_kerestinec = get_chunk(opts[:position] + 4)

    departures = all_departures -
      departures_novaki - departures_kerestinec

    populate_database({
      direct: departures,
      novaki: departures_novaki,
      kerestinec: departures_kerestinec
    }, opts)
  end

  private

  def self.validate!(opts)
    return if opts[:position] && opts[:line] &&
      opts[:direction]

    raise ArgumentError
  end
end

def populate_chunk_pairs(position, line, day_type)
  [[position, Direction.zagreb],
   [position + 7, Direction.samobor]].each do |pair|
    Chunk.fetch(
      position: pair.first,
      line: line,
      direction: pair.last,
      day_type: day_type
    ) 
  end
end

populate_chunk_pairs(7, Line.first, DayType.radni)
populate_chunk_pairs(23, Line.first, DayType.subota)
populate_chunk_pairs(38, Line.first, DayType.nedjelja)
