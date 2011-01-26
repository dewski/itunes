require File.expand_path('../spec_helper', __FILE__)

describe ITunes do
  describe ".limit" do
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

  end
end