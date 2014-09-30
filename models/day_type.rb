require "mongoid"

class DayType
  include Mongoid::Document

  field :title, type: String

  has_many :departures

  def self.radni
    where(title: /radni dan/).first
  end

  def self.subota
    where(title: /subota/).first
  end

  def self.nedjelja
    where(title: /nedjelja/).first
  end

  def self.now
    case Time.now.wday
    when 1..5
      radni
    when 6
      subota
    when 0
      nedjelja
    end
  end
end
