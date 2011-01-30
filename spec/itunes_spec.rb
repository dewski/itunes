require File.expand_path('../spec_helper', __FILE__)

describe ITunes do

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  describe "initialize" do
    it "should allow a limit to be set on initialization" do
      @client = ITunes.new(2)
      @client.limit.should == 2
    end
  end

  describe "#limit" do
    before(:each) do
      @client = ITunes.new
    end

    it 'should not set a limit by default' do
      @client.limit.should be_nil
    end

    it "should allow a limit to be set" do
      @client.limit = 5
      @client.limit.should == 5
    end

    it "should ignore the limit when set to 0" do
      @client.limit = 0
      response = @client.all('Michael Jackson')
      response.result_count.should > 0
    end
  end

  describe "#adapter" do
    before(:each) do
      @client = ITunes.new
    end

    it "should instantiate with the default adapter" do
      @client.adapter.should == Faraday.default_adapter
    end

    it "should allow an adapter to be set" do
      @client.adapter = :typhoeus
      @client.adapter.should == :typhoeus
    end
  end

  describe ".all" do
    it "should raise an ArgumentError when passed a nil search term" do
      lambda {
        ITunes.all(nil)
      }.should raise_error
    end

    it "should accept a limit option" do
      response = ITunes.all('Michael Jackson', :limit => 2)
      response.result_count.should == 2
    end

  end

  describe ".music" do
    it "should return music results" do
      response = ITunes.music('Jose James')
      response.results.each do |result|
        result.kind.should == 'song'
      end
    end
  end

  describe ".podcast" do
    it "should return podcast results" do
      response = ITunes.podcast('Beyondjazz')
      response.results.each do |result|
        result.kind.should == 'podcast'
      end
    end
  end

  describe ".movie" do
    it "should return movie results" do
      response = ITunes.movie('Blade Runner')
      response.results.each do |result|
        result.kind.should == 'feature-movie'
      end
    end
  end

  describe ".music_video" do
    it "should return music video results" do
      response = ITunes.music_video('Sabotage')
      response.results.each do |result|
        result.kind.should == 'music-video'
      end
    end
  end

  describe ".audiobook" do
    it "should return audiobook results" do
      response = ITunes.audiobook('Ernest Hemingway')
      response.results.each do |result|
        result.wrapper_type.should == 'audiobook'
      end
    end
  end

  describe ".short_film" do
    it "should return short film results" do
      response = ITunes.short_film('Pixar')
      response.results.each do |result|
        result.kind.should == 'feature-movie'
      end
    end
  end

  describe ".tv_show" do
    it "should return tv show results" do
      response = ITunes.tv_show('Lost')
      response.results.each do |result|
        result.kind.should == 'tv-episode'
      end
    end
  end

end