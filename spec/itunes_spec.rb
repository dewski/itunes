require File.expand_path('../spec_helper', __FILE__)

describe Tunes do
  after do
    Tunes.reset
  end

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  context "when delegating to a client" do
    it "should return the same results as a client" do
      Tunes.music('Jose James').should == Tunes::Client.new.music('Jose James')
    end
  end

  describe '.client' do
    it 'should return and ITunes::Client' do
      Tunes.client.should be_a Tunes::Client
    end
  end

  describe '.respond_to?' do
    it "should take an optional argument" do
      Tunes.respond_to?(:new, true).should be_true
    end
  end

  describe ".new" do
    it "should return an ITunes::Client" do
      Tunes.new.should be_a ITunes::Client
    end
  end

  describe ".limit" do
    it 'should return the default limit' do
      Tunes.limit.should == ITunes::Configuration::DEFAULT_LIMIT
    end
  end

  describe ".limit=" do
    it "should set the limit" do
      Tunes.limit = 5
      Tunes.limit.should == 5
    end
  end

  describe ".adapter" do
    it "should instantiate with the default adapter" do
      Tunes.adapter.should == Faraday.default_adapter
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Tunes.adapter = :typhoeus
      Tunes.adapter.should == :typhoeus
    end
  end

  describe ".configure" do
    Tunes::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Tunes.configure do |config|
          config.send("#{key}=", key)
          Tunes.send(key).should == key
        end
      end
    end
  end
end