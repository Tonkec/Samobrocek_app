class DepartureExtractor
  # give me season and day and I'll return you departures
  # for that day
  def self.execute(season, day_type)
    @season = season
    @parent = day_type.parent.parent

    [{:is_return => false, :departures => departures[0]},
     {:is_return => true, :departures => departures[2]}]
  end

  def self.departures
    case @season
    when 'zimski'
      @parent.
        next_element.
        css("td")

    when 'jesenski'
      @parent.
        next_element.
        css("td")
    when 'ljetni'
      @parent.
        next_element.
        next_element.
        css("td")
    else
      raise ArgumentError.new('season is wrong')
    end
  end
end
