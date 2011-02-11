require File.expand_path('../request', __FILE__)

module ITunes
  class Client

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new Client
    def initialize(options={})
      options = ITunes.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    alias :api_endpoint :endpoint

    include Request
    include Search
    include Lookup

  end
end