module ITunes
  module Lookup

    ID_TYPES =  { :amg_artist => 'amgArtistId', :id => 'id', :amg_album => 'amgAlbumId', :upc => 'upc' }

    # Performs a lookup request based on iTunes IDs, UPCs/ EANs, and All Music Guide (AMG) IDs
    # @param [String] id
    # @option options [Symbol] :id_type used to specify the option type being passed, valid types are: id, upc, amg_artist, amg_album
    # @raise [ArgumentError] If an invalid id_type is specified in options
    def lookup(id, options={})
      id_type = options.delete(:id_type) || :id
      raise ArgumentError, 'invalid id_type.' unless ID_TYPES.keys.include?(id_type.to_sym)

      warn "#{Kernel.caller.first}: [DEPRECATION] id_type option is deprecated and will be permanently removed in the next major version. Please use ITunes::Lookup methods (amg_artist, amg_album, and upc) instead." unless id_type == :id

      perform_lookup(ID_TYPES[id_type.to_sym], id, options)
    end

    # Performs a lookup request based on an All Music Guide (AMG) Artist ID
    # @param [String] id
    # @option options [Symbol]
    def amg_artist(id, options={})
      perform_lookup('amgArtistId', id, options)
    end
    alias :amg_artists :amg_artist

    # Performs a lookup request based on an All Music Guide (AMG) Album ID
    # @param [String] id
    # @option options [Symbol]
    def amg_album(id, options={})
      perform_lookup('amgAlbumId', id, options)
    end
    alias :amg_albums :amg_album

    # Performs a lookup request based on a UPC
    # @param [String] id
    # @option options [Symbol]
    def upc(id, options={})
      perform_lookup('upc', id, options)
    end

    # Performs a lookup request based on an ISBN
    # @param [String] id
    # @option options [Symbol]
    def isbn(id, options={})
      perform_lookup('isbn', id, options)
    end

    private

    def perform_lookup(id_type, id, options)
      id = id.split(',') if id.kind_of?(String)
      options.merge!(id_type => id.join(','))
      request('Lookup', options)
    end

  end
end