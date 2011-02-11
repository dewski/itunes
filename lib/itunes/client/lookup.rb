module ITunes
  module Lookup

    ID_TYPES =  { :amg_artist => 'amgArtistId', :id => 'id', :amg_album => 'amgAlbumId', :upc => 'upc' }

    # Performs a lookup request based on iTunes IDs, UPCs/ EANs, and All Music Guide (AMG) IDs
    # @param [String] id
    # @option options [Symbol] :id_type used to specify the option type being passed, valid types are: id, upc, amg_artist, amg_album
    # @raise [ArgumentError] If an invalid id_type is specified in options
    def lookup(id, options={})
      id = id.split(',') if id.kind_of?(String)
      id_type = options.delete(:id_type) || :id

      raise ArgumentError, 'invalid id_type.' unless ID_TYPES.keys.include?(id_type.to_sym)

      options.merge!({ ID_TYPES[id_type.to_sym] => id.join(',') })
      request('Lookup', options)
    end

  end
end