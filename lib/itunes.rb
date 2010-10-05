require 'httparty'

class ITunes
  include HTTParty

  base_uri 'ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/ws'
  format :json
  
  attr_accessor :limit

  def method_missing(name, *args)
    methods = %q{movie podcast music music_video audiobook short_film tv_show all}

    if methods.include?(name.to_s)
      camelcase = name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      camelcase[0] = camelcase[0].chr.downcase
      
      @limit = args[1].delete(:limit) unless args[1].nil? # will return nil if there is no limit

      request(args.first, camelcase)
    else
      super(name, *args)
    end
  end
  
  def initialize(limit=nil)
    @limit = limit
  end
  
  # So you don't have to create an instance if you don't need to
  def self.music(terms, opts=nil)
    self.new.music(terms, opts)
  end
  
  def self.podcast(terms, opts=nil)
    self.new.podcast(terms, opts)
  end
  
  def self.movie(terms, opts=nil)
    self.new.movie(terms, opts)
  end
  
  def self.music_video(terms, opts=nil)
    self.new.music_video(terms, opts)
  end
  
  def self.audiobook(terms, opts=nil)
    self.new.audiobook(terms, opts)
  end
  
  def self.short_film(terms, opts=nil)
    self.new.short_film(terms, opts)
  end
  
  def self.tv_show(terms, opts=nil)
    self.new.tv_show(terms, opts)
  end
  
  def self.all(terms, opts=nil)
    self.new.all(terms, opts)
  end

  private
    def request(term, media='all')
      raise ArgumentError, 'you need to search for something, provide a term.' if term.nil?
      
      # 
      query = { :term => term, :media => media }
      query.merge!({ :limit => @limit }) unless @limit.nil? or @limit == 0
      
      self.class.get('Search', { :query => query })
    end
end
