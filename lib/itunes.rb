require 'httparty'

class ITunes
  include HTTParty

  base_uri 'ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/ws'
  format :json

  def method_missing(name, *args)
    methods = %q{movie podcast music music_video audiobook short_film tv_show all}

    if methods.include?(name.to_s)
      camelcase = name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      camelcase[0] = camelcase[0].chr.downcase

      request(args.first, camelcase)
    else
      super(name, *args)
    end
  end
  
  # So you don't have to create an instance if you don't need to
  def self.music(terms)
    self.new.music(terms)
  end
  
  def self.podcast(terms)
    self.new.podcast(terms)
  end
  
  def self.movie(terms)
    self.new.movie(terms)
  end
  
  def self.music_video(terms)
    self.new.music_video(terms)
  end
  
  def self.audiobook(terms)
    self.new.audiobook(terms)
  end
  
  def self.short_film(terms)
    self.new.short_film(terms)
  end
  
  def self.tv_show(terms)
    self.new.tv_show(terms)
  end
  
  def self.all(terms)
    self.new.all(terms)
  end

  private
    def request(term, media='all')
      raise ArgumentError, 'you need to search for something, provide a term.' if term.nil?

      self.class.get('Search', {
        :query => {
          :term => term,
          :media => media
        }
      })
    end
end
