module ITunes
  module Search

    # Performs a music search
    # @param [String] term The search term
    # @option options [Symbol]
    def music(term, options={})
      search(term, 'music', options)
    end

    # Performs a movie search
    # @param [String] term The search term
    # @option options [Symbol]
    def movie(term, options={})
      search(term, 'movie', options)
    end

    # Performs a podcast search
    # @param [String] term The search term
    # @option options [Symbol]
    def podcast(term, options={})
      search(term, 'podcast', options)
    end

    # Performs a music video search
    # @param [String] term The search term
    # @option options [Symbol]
    def music_video(term, options={})
      search(term, 'musicVideo', options)
    end

    # Performs an audiobook search
    # @param [String] term The search term
    # @option options [Symbol]
    def audiobook(term, options={})
      search(term, 'audiobook', options)
    end

    # Performs a short film search
    # @param [String] term The search term
    # @option options [Symbol]
    def short_film(term, options={})
      search(term, 'shortFilm', options)
    end

    # Performs a tv show search
    # @param [String] term The search term
    # @option options [Symbol]
    def tv_show(term, options={})
      search(term, 'tvShow', options)
    end

    # Performs a search on all itunes content
    # @param [String] term The search term
    # @option options [Symbol]
    def all(term, options={})
      search(term, 'all', options)
    end

    private

      def search(term, media='all', options={})
        raise ArgumentError, 'you need to search for something, provide a term.' if term.nil? || term.length == 0

        params = { :term => term, :media => media }
        if options.has_key?(:limit)
          params.merge!(:limit => options.delete(:limit))
        elsif limit
          params.merge!({ :limit => limit })
        end
        params.delete(:limit) if params[:limit] && params[:limit] == 0
        params.merge!(options)

        # clear empty key/value pairs
        params.reject! { |key, value| value.nil? }

        request('Search', params)
      end

  end
end