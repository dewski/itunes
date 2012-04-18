require 'faraday_middleware'
require 'tunes/configuration'
require 'tunes/client'

module Tunes
  extend Configuration

  # Alias for Tunes::Client.new
  #
  # @return [Tunes::Client]
  def self.client(options={})
    Client.new options
  end

  # Alias for Tunes::Client.new
  #
  # @return [Tunes::Client]
  def self.new(options={})
    Client.new options
  end

  # Delegate to Tunes::Client
  def self.method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    new.respond_to?(method, include_private) || super(method, include_private)
  end
end
