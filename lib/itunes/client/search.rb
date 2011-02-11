module ITunes
  module Search

    def music(term, options={})
      search(term, 'music', options)
    end

    def movie(term, options={})
      search(term, 'movie', options)
    end

    def podcast(term, options={})
      search(term, 'podcast', options)
    end

    def music_video(term, options={})
      search(term, 'musicVideo', options)
    end

    def audiobook(term, options={})
      search(term, 'audiobook', options)
    end

    def short_film(term, options={})
      search(term, 'shortFilm', options)
    end

    def tv_show(term, options={})
      search(term, 'tvShow', options)
    end

    def all(term, options={})
      search(term, 'all', options)
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
        params.merge!(options)

        # clear empty key/value pairs
        params.reject! { |key, value| value.nil? }

        request('Search', params)
      end

  end
end