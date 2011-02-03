module ITunes
  module Lookup

    ID_TYPES =  { :amg_artist => 'amgArtistId', :id => 'id', :amg_album => 'amgAlbumId', :upc => 'upc' }

    def lookup(id, options={})
      id = id.split(',') if id.kind_of?(String)
      id_type = options.delete(:id_type) || :id

      raise ArgumentError, 'invalid id_type.' unless ID_TYPES.keys.include?(id_type)

      options.merge!({ ID_TYPES[id_type.to_sym] => id.join(',') })
      request('Lookup', options)
    end

  end
end