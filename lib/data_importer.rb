class DataImporter
  def initialize(opts)
    @page = opts[:page] ||
      raise(ArgumentError.new("can't find :page in
                              the arguments"))

    load_mongoid
    drop_database
  end

  def import_all
    import_line
    import_day_types
    import_directions
    import_route_types

    @page.schema[:departure_positions].each do |day_type, position|
      import_chunk_pairs(position,
                         Line.first,
                         DayType.send(day_type),
                         @page)
    end

    true
  end

  private

    def load_mongoid
      Mongoid.load!("mongoid.yml", :development)
    end

    def drop_database
      Line.destroy_all
      DayType.destroy_all
      Direction.destroy_all
      Departure.destroy_all
      RouteType.destroy_all
    end

    def import_chunk_pairs(position, line, day_type, page)
      [[position, Direction.zagreb],
       [position + 7, Direction.samobor]].each do |pair|
        Chunk.fetch(
          position: pair.first,
          line: line,
          direction: pair.last,
          day_type: day_type,
          page: page
        ) 
      end
    end

    def import_line
      line_name = 
        @page.get_title(@page.schema[:line_name]).first
      Line.create(title: line_name)
    end

    def import_day_types
      day_types  = @page.get_title(@page.schema[:day_types])
      day_types.each {|t| DayType.create(title: t)}
    end

    def import_directions
      directions = @page.get_title(@page.schema[:directions])
      directions.each {|t| Direction.create(title: t)}
    end

    def import_route_types
      types      = @page.get_title(@page.schema[:route_types])

      types.each {|t| RouteType.create(title: t)}
      RouteType.create(title: "direct")
    end
end
