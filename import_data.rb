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
    page = Page.new(
      :url => "http://www.samoborcek.hr/vozni-red/"
    )

    importer = DataImporter.new(
      :page => page
    )

    importer.execute
  end
end
