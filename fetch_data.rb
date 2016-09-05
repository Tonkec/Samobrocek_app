require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'pry'

require './lib/departure_extractor'
require './lib/page'
require './lib/database_populator'
require './lib/database'
require './lib/data_importer'

Database.load

class Nokogiri::XML::Element
  def normalized_text
    text.gsub(" ", "").gsub(/\b\W+\b/, " ").
      gsub(/\b\W+$/, "").downcase
  end

  def downcased_text
    text.tr('A-Z', 'a-z')
  end
end

SEASONS = %w.ljetni zimski jesenski.

class FetchData
  def self.execute(season, verbose = false)
    validate_season season

    page = Page.new(
      url: "http://www.samoborcek.hr/vozni-red/"
    )

    importer = DataImporter.new(
      page: page,
      season: season,
      verbose: verbose
    )

    importer.execute

    if verbose
      puts "Imported #{Departure.count} departures"
    end
  end

  private

  def self.validate_season(season)
    unless SEASONS.include?(season)
      raise(ArgumentError.new("#{season} is not a valid season. use one of these: #{SEASONS.join(", ")}"))
    end
  end
end
