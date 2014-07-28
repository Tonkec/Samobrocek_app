require "mongoid"

class RouteType
  include Mongoid::Document

  field :title, type: String

  has_many :departures

  def self.kerestinec
    where(title: /kerestin/).first
  end

  def self.novaki
    where(title: /novak/).first
  end

  def self.direct
    where(title: "direct").first
  end
end
