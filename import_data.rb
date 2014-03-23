require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "pry"

require "./models/day_type"
require "./models/line"
require "./models/direction"
require "./models/departure"
require "./models/route_type"

require "./page"
require "./chunk"

Mongoid.load!("mongoid.yml", :development)

Line.destroy_all
DayType.destroy_all
Direction.destroy_all
Departure.destroy_all
RouteType.destroy_all

POSITION = {
  :line_name => 3,
  :day_types => [5, 21, 36],
  :directions => [6, 13],
  :route_types => [8, 10]
}
URL = "http://www.samoborcek.hr/linija.php?id=18" 

page = Page.new(URL)

line_name  = page.get_title(POSITION[:line_name]).first
day_types  = page.get_title(POSITION[:day_types])
directions = page.get_title(POSITION[:directions])
types      = page.get_title(POSITION[:route_types])

line       = Line.create(title: line_name)
day_types  = day_types.map {|t| DayType.create(title: t)}
directions = directions.map {|t| Direction.create(title: t)}
types      =  types.map {|t| RouteType.create(title: t)}
types      << RouteType.create(title: "direct")

def populate_chunk_pairs(position, line, day_type, page)
  [[position, Direction.zagreb],
   [position + 7, Direction.samobor]].each do |pair|
    Chunk.fetch(
      position: pair.first,
      line: line,
      direction: pair.last,
      day_type: day_type,
      page: page
    ) 
  end
end

populate_chunk_pairs(7,
                     Line.first,
                     DayType.radni,
                     page)

populate_chunk_pairs(23,
                     Line.first,
                     DayType.subota,
                     page)

populate_chunk_pairs(38,
                     Line.first,
                     DayType.nedjelja,
                     page)
