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
require "./data_importer"

schema = {
  :line_name => 3,
  :day_types => [5, 21, 36],
  :directions => [6, 13],
  :route_types => [8, 10],
  :departure_positions => {
    :radni => 7,
    :subota => 23,
    :nedjelja => 38 
  }
}

page = Page.new(
  :url => "http://www.samoborcek.hr/linija.php?id=18",
  :schema => schema
)

importer = DataImporter.new(
  :page => page
)

importer.import_all
