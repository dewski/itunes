module ITunes
  module AdditionalMetadata
    PEOPLE_TYPES=%w(Actor Director Artist Producer Screenwriter)
    def read_people(people_type, html)
      raise ArgumentError, "you must pass #{PEOPLE_TYPES.join('|')}" unless PEOPLE_TYPES.include?( people_type )
      nodes = html.xpath("//div[starts-with(@metrics-loc,'Titledbox_#{people_type}')]")
      nodes.map{|n|n.search('.//a').map{|a|a.text}}.flatten
    end
    def get_additional_metadata(result)
      raise ArgumentError, 'you must pass in a single result object containing track_url' unless result && result.track_view_url
      html = Nokogiri::HTML(Faraday.new.get(result.track_view_url.gsub(/\?.*/,'')).body)
      additional_metadata = PEOPLE_TYPES.inject({}) do |hash, type|
        hash["#{type}s"]=read_people(type, html)
        hash
      end
      additional_metadata
    end
  end
end

