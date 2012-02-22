require 'simplecov'
SimpleCov.start do
  add_group 'ITunes', 'lib/itunes'
  add_group 'Faraday Middleware', 'lib/faraday'
  add_group 'Specs', 'spec'
end

require File.expand_path('../../lib/itunes', __FILE__)

require 'rspec'
require 'vcr'

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.stub_with              :webmock
end
