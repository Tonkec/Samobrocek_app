class Page
  def initialize(url)
    if url
      puts "Fetching data..."
      @content = Nokogiri::HTML(open(url))
      puts "Success!"

      @xpath = @content.xpath("//tbody//p")
    end
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
