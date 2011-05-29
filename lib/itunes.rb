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

  # Delegate to ITunes::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to ITunes::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
