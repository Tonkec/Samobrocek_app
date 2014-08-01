require "mongoid"

class Departure
  include Mongoid::Document

  field :time, type: Integer
  field :starred, type: Boolean, default: false
  field :is_return, type: Boolean, default: false

  belongs_to :route_type
  belongs_to :direction
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

  def humanized_route_type
    buffer = case route_type.title
             when /kerestin/
               "preko kerestinca"
             when /novak/
               "preko novaka"
             else 
               ""
             end

    if starred?
      buffer += (buffer.blank? ? "preko ljubljanice" : " i ljubljanice")
    end

    if buffer.blank?
      "brza linija"
    else
      buffer
    end
  end
end
