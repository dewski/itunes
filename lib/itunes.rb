require 'faraday_middleware'
require 'faraday/rashify'

class ITunes

  ID_TYPES =  { :amg_artist => 'amgArtistId', :id => 'id', :amg_album => 'amgAlbumId', :upc => 'upc' }

  attr_accessor :limit, :adapter

  def method_missing(name, *args)
    methods = %q{movie podcast music music_video audiobook short_film tv_show all}

    if methods.include?(name.to_s)
      camelcase = name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      camelcase[0] = camelcase[0].chr.downcase

      @limit = args[1].delete(:limit) unless args[1].nil? # will return nil if there is no limit

      search(args.first, camelcase)
    else
      super(name, *args)
    end
  end

  def initialize(limit=nil)
    @limit = limit
    @adapter = Faraday.default_adapter
    @base_uri = 'http://ax.itunes.apple.com'
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

  def lookup(id, options={})
    id = id.split(',') if id.kind_of?(String)
    id_type = options.delete(:id_type) || :id

    raise ArgumentError, 'invalid id_type.' unless ID_TYPES.keys.include?(id_type)

    options.merge!({ ID_TYPES[id_type.to_sym] => id.join(',') })
    request('Lookup', options)
  end

  def self.lookup(id, options={})
    self.new.lookup(id, options)
  end


  private
    def search(term, media='all')
      raise ArgumentError, 'you need to search for something, provide a term.' if term.nil?

      params = { :term => term, :media => media }
      params.merge!({ :limit => @limit }) unless @limit.nil? or @limit == 0

      request('Search', params)
    end

    def request(request_type, params)
      url = '/WebObjects/MZStoreServices.woa/wa/ws' + request_type

      response = connection.get do |req|
        req.url url, params
      end
      response.body
    end

    def connection
      @conn ||= Faraday::Connection.new(:url => @base_uri) do |builder|
        builder.adapter(@adapter)
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Rashify
      end
    end
end
