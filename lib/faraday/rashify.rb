require 'faraday'

# @private
module Faraday
  # @private
  class Response::Rashify < Response::Middleware
    begin
      require 'hashie'
      require 'rash'
    rescue LoadError, NameError => error
      self.load_error = error
    end

    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        response_body = response[:body]
        if response_body.is_a?(Hash)
          response[:body] = ::Hashie::Rash.new(response_body)
        elsif response_body.is_a?(Array)
          response[:body] = response_body.map{|item| item.is_a?(Hash) ? ::Hashie::Rash.new(item) : item}
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end
  end
end
