require "mongoid"

class Departure
  include Mongoid::Document

  field :time, type: Time
  field :starred, type: Boolean, default: false

  belongs_to :route_type
  belongs_to :direction
  belongs_to :line
  belongs_to :day_type
end
