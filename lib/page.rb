class Page
  attr_reader :schema

  def initialize(opts)
    @url = opts[:url] ||
      raise(ArgumentError.new("can't find
        :url in the arguments"))

    @schema = opts[:schema] ||
      raise(ArgumentError.new("can't find
        :schema in the arguments"))

    fetch_page
  end

  def fetch_page
    puts "Fetching data..."
    @content = Nokogiri::HTML(open(@url))
    puts "Success!"

    @xpath = @content.xpath("//tbody//p")
  end

  def get_chunk(position)
    Array(position).map do |position|
      @xpath[position].text.split(" ").map do |el|
        el.gsub(/\W+$/, "").gsub(/(,|\.)/, ":")
      end
    end.flatten
  end

  def get_title(position)
    Array(position).map do |position|
      normalize_raw_titles @xpath[position].text
    end
  end

  private

    def normalize_raw_titles(raw)
      raw.gsub(" ", "").gsub(/\b\W+\b/, " ").
        gsub(/\b\W+$/, "").downcase
    end
end
