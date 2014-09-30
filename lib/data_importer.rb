class DataImporter
  DAY_TYPES = ["radni dan", "subota", "nedjelja"]

  def initialize(opts)
    @page = opts[:page] ||
      raise(ArgumentError.new("can't find :page in
                              the arguments"))
    @season_argument = opts[:season] ||
      raise(ArgumentError.new("season is missing"))

    Database.drop!
  end

  def execute
    @season = @page.css("div.col-1-3:contains('#{@season_argument.upcase}')")

    @line_name = "autobusni kolodvor".upcase

    import_all
  end

  def import_all
    import_line_names(@line_name).each do |line|
      @line = line
      @day_types = import_day_types

      import_route_types
      import_departures
    end
  end

  private

    def import_departures
      @day_types.each do |day_type|
        DepartureExtractor.execute(@season_argument, day_type).each do |raw_departure|

          departures_fragmented = raw_departure[:departures].text.
            split(/Polasci.+?:/)[1..-1].map do |fragment|
              fragment.gsub(/[^\w\.\*, ]/, '').
                gsub(/(\.)\s+(\w+)/, '\1\2'). # all hail *10. 00
                split(' ')
          end

          departures_normalized = Hash[[:all, :novaki, :kerestinec].
                                       zip(departures_fragmented)]

          DatabasePopulator.execute(
            departures: departures_normalized,
            is_return: raw_departure[:is_return],
            day_type: DayType.
              where(title: /#{day_type.normalized_text.gsub(/\s/,'')[0..3]}/).
              first
          )
        end
      end
    end

    def import_line_names(title)
      @season.css("h3:contains('#{title}')").map do |line|
        Line.find_or_create_by(title: line.text)
        line
      end
    end

    def import_day_types
      DAY_TYPES.each {|dt| DayType.create(title: dt)}

      @line.parent.parent.css("em").select do |day_type|
        day_type.text =~ /\w/
      end
    end

    def import_route_types
      types      = @line.parent.parent.css("td strong")[1..2]

      types.each {|t| RouteType.find_or_create_by(title: t.normalized_text)}
      RouteType.find_or_create_by(title: "direct")
      RouteType.find_or_create_by(title: "ljubljanica")
    end
end
