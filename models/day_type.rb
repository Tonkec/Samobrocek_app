require "mongoid"
require "holidays"

class DayType
  include Mongoid::Document

  field :title, type: String

  has_many :departures

  class << self
    def radni
      where(title: /radni dan/).first
    end
    alias_method :weekday, :radni

    def subota
      where(title: /subota/).first
    end
    alias_method :saturday, :subota

    def nedjelja
      where(title: /nedjelja/).first
    end
    alias_method :sunday, :nedjelja

    def now
      unless Holidays.on(Time.now, :hr).empty?
        return nedjelja
      end

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

  def weekend?
    title == "subota" || title == "nedjelja"
  end
end
