require File.expand_path('../spec_helper', __FILE__)

describe ITunes do
  after do
    ITunes.reset
  end

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  describe ".limit" do
    it 'should return the default limit' do
      ITunes.limit.should == ITunes::Configuration::DEFAULT_LIMIT
    end
  end

  describe ".limit=" do
    it "should set the limit" do
      ITunes.limit = 5
      ITunes.limit.should == 5
    end
  end

  describe ".adapter" do
    it "should instantiate with the default adapter" do
      ITunes.adapter.should == Faraday.default_adapter
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      ITunes.adapter = :typhoeus
      ITunes.adapter.should == :typhoeus
    end
  end

end