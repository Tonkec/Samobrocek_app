require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "pry"

require "./lib/page"
require "./lib/database_populator"
require "./lib/database"
require "./lib/data_importer"

Database.load
Database.drop!

class Nokogiri::XML::Element
  def normalized_text
    text.gsub(" ", "").gsub(/\b\W+\b/, " ").
      gsub(/\b\W+$/, "").downcase
  end

  def downcased_text
    text.tr('A-Z', 'a-z')
  end
end

class ImportData
  def self.execute
    schema = {
      :directions => [6, 13],
      :route_types => [8, 10],
      :departure_positions => {
        :radni => 7,
        :subota => 23,
        :nedjelja => 38 
      }
    }

    page = Page.new(
      :url => "http://www.samoborcek.hr/vozni-red/",
      :schema => schema
    )

    importer = DataImporter.new(
      :page => page
    )

    importer.execute
  end
end
