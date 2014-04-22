require "mongoid"

class Line
  include Mongoid::Document

  field :title, type: String
  has_many :departures
end
