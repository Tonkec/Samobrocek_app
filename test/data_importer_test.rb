require "minitest/autorun"
require "pry"

require "./test/helper"

require "./lib/departure_extractor"
require "./lib/page"
require "./lib/database_populator"
require "./lib/database"
require "./lib/data_importer"

Database.load
Database.drop!

describe DataImporter do
  before do
    @page = Page.new(path: "data/original.html")
    @subject = DataImporter.new({
      page: @page,
      season: "zimski"
    })
  end

  it "works as expected"
end
