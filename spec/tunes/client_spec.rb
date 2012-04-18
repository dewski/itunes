require 'spec_helper'

describe Tunes::Client do
  before do
    @client = Tunes::Client.new
  end

  use_vcr_cassette :record => :new_episodes, :match_requests_on => [:uri, :method]

  describe ".lookup" do
    it "should return results for valid ids" do
      item = @client.lookup('396405320')
      item.results.first.collection_name.should == 'Hold it Down - Single'
      item.results.first.primary_genre_name == 'Dance'
    end

    describe "when passing an id_type other than amg or upc" do
      it "should raise an error" do
        lambda {
          @client.lookup('1235', :id_type => :lastfm)
        }.should raise_error
      end
    end
  end

  describe '.amg_artist' do
    it "should return a valid item when passed a single id" do
      items = @client.amg_artist('792844')
      items.result_count.should == 1
    end

    it "should return results when passed a comma separated string of ids" do
      items = @client.amg_artist('468749,5723')
      items.result_count.should == 2
    end

    it "should return results when passed an array of ids" do
      items = @client.amg_artist(['468749','5723'])
      items.result_count.should == 2
    end

    it 'should be aliased as amg_artists' do
      @client.amg_artist(['468749','5723']).should == @client.amg_artists(['468749','5723'])
    end
  end

  describe '.amg_album' do
    it "should return a valid item when passed a single id" do
      items = @client.amg_album('15197')
      items.results.first.artist_name.should == 'Wilson Pickett'
    end

    it "should return results when passed a comma separated string of ids" do
      items = @client.amg_album('15197,15198')
      items.results.first.artist_name.should == 'Wilson Pickett'
    end

    it "should return results when passed an array of ids" do
      items = @client.amg_album(['15197','15198'])
      items.results.first.artist_name.should == 'Wilson Pickett'
    end

    it 'should be aliased as amg_albums' do
      @client.amg_album(['15197','15198']).should == @client.amg_albums(['15197','15198'])
    end
  end

  describe '.upc' do
    it "should return a valid item when passed a single id" do
      item = @client.upc('5024545486520')
      item.results.first.collection_name.should == 'Untrue'
      item.results.first.artist_name.should == 'Burial'
    end
  end

  describe '.isbn' do
    it 'should return a valid item when passed a single id' do
      item = @client.isbn('9780316069359')
      item.results.first.kind.should == 'ebook'
      item.results.first.track_name.should == 'The Fifth Witness'
    end
  end

  describe "search" do
    describe ".all" do
      it "should raise an ArgumentError when passed a nil search term" do
        lambda {
          @client.all(nil)
        }.should raise_error
      end

      it "should raise an ArgumentError when passed an empty string as a search term" do
        lambda {
          @client.all('')
        }.should raise_error
      end

      it "should accept a limit option" do
        response = @client.all('Michael Jackson', :limit => 2)
        response.result_count.should == 2
      end

      it "should ignore the limit when set to 0" do
        @client.limit = 0
        response = @client.all('Michael Jackson')
        response.result_count.should > 0
      end
    end

    describe ".music" do
      it "should return music results" do
        response = @client.music('Jose James')
        response.results.each do |result|
          ['music-artist', 'music-track', 'album', 'music-video', 'mix', 'song'].should include(result.kind)
        end
      end
    end

    describe ".podcast" do
      it "should return podcast results" do
        response = @client.podcast('Beyondjazz')
        response.results.each do |result|
          result.kind.should == 'podcast'
        end
      end
    end

    describe ".movie" do
      it "should return movie results" do
        response = @client.movie('Blade Runner')
        response.results.each do |result|
          result.kind.should == 'feature-movie'
        end
      end
    end

    describe ".music_video" do
      it "should return music video results" do
        response = @client.music_video('Sabotage')
        response.results.each do |result|
          result.kind.should == 'music-video'
        end
      end
    end

    describe ".audiobook" do
      it "should return audiobook results" do
        response = @client.audiobook('Ernest Hemingway')
        response.results.each do |result|
          result.wrapper_type.should == 'audiobook'
        end
      end
    end

    describe ".short_film" do
      it "should return short film results" do
        response = @client.short_film('Pixar')
        response.results.each do |result|
          result.kind.should == 'feature-movie'
        end
      end
    end

    describe ".tv_show" do
      it "should return tv show results" do
        response = @client.tv_show('Lost')
        response.results.each do |result|
          result.kind.should == 'tv-episode'
        end
      end
    end

    describe ".software" do
      it "should return tv show results" do
        response = @client.software('Doodle Jump')
        response.results.each do |result|
          ['software', 'iPadSoftware', 'macSoftware'].should include(result.kind)
        end
      end
    end

    describe ".ebook" do
      it "should return ebook results" do
        response = @client.ebook('Alice in Wonderland')
        response.results.each do |result|
          result.kind.should == 'ebook'
        end
      end
    end
  end

end