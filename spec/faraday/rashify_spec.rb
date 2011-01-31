require 'spec_helper'

require File.expand_path('../../../lib/faraday/rashify', __FILE__)

describe Faraday::Response::Rashify do

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  describe "converting camelcase keys to underscores" do
    it "should respond with a hashie mash with underscored keys" do
      response = ITunes.lookup('358735381')
      response.respond_to?(:result_count).should be_true
      response.results.first.respond_to?(:wrapper_type).should be_true
      response.results.first.respond_to?(:collection_type).should be_true
    end
  end
end
