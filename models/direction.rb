require "mongoid"

class Direction
  include Mongoid::Document

  field :title, type: String

  has_many :departures

  def self.samobor
    where(title: "polasci iz samobora").first
  end

  def self.zagreb
    where(title: "polasci iz a k zagreba").first
  end
end
