module ITunes
  module Search

    def method_missing(name, *args)
      methods = %q{movie podcast music music_video audiobook short_film tv_show all}

      if methods.include?(name.to_s)
        camelcase = name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
        camelcase[0] = camelcase[0].chr.downcase

        options = args[1] || {}
        search(args.first, camelcase, options)
      else
        super(name, *args)
      end
    end

    private

      def search(term, media='all', options={})
        raise ArgumentError, 'you need to search for something, provide a term.' if term.nil?

        params = { :term => term, :media => media }
        if options.has_key?(:limit)
          params.merge!(:limit => options.delete(:limit))
        elsif limit
          params.merge!({ :limit => limit })
        end
        params.delete(:limit) if params[:limit] && params[:limit] == 0

        request('Search', params)
      end

  end
end