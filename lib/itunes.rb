require 'faraday_middleware'
require 'itunes/configuration'
require 'itunes/client'

module ITunes
  extend Configuration

  # Alias for ITunes::Client.new
  #
  # @return [ITunes::Client]
  def self.client(options={})
    ITunes::Client.new(options)
  end

  # Alias for ITunes::Client.new
  #
  # @return [ITunes::Client]
  def self.new(options={})
    ITunes::Client.new(options)
  end

  # Delegate to ITunes::Client
  def self.method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    new.respond_to?(method, include_private) || super(method, include_private)
  end
end
