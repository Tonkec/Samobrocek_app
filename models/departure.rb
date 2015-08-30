require "mongoid"

class Departure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :time, type: Integer
  field :starred, type: Boolean, default: false
  field :is_return, type: Boolean, default: false

  belongs_to :route_type
  belongs_to :line
  belongs_to :day_type

  alias_method :time_in_seconds, :time
  def time
    Time.now.beginning_of_day + time_in_seconds
  end

  def time_humanized
    time.strftime("%H:%M")
  end

  def from_now_in_seconds
    (time_in_seconds - Time.now.seconds_since_midnight).abs.round
  end

  def ljubljanica?
    starred? || DayType.now.weekend?
  end

  def novaki?
    route_type.title =~ /novak/
  end

  def kerestinec?
    route_type.title =~ /kerestin/
  end

  def fast?
    !ljubljanica? &&
      !kerestinec? &&
      !novaki?
  end

  def humanized_route_type
    buffer = case route_type.title
             when /kerestin/
               "Kerestinec Cruise"
             when /novak/
               "Tour de Novaki"
             else
               ""
             end

    if buffer.blank?
      ljubljanica? ? "Ljubljanica Voyage" : "Fast and Fourius"
    else
      buffer
    end
  end
end
