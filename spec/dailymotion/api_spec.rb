require "spec_helper"
require "dailymotion"
require "pry"

describe Dailymotion::API do
  it "should be initialized with a token" do
    @api = Dailymotion::API.new("ABCD")

    @api.token.should eq("ABCD")
  end

  describe "with a token" do
    subject { Dailymotion::API.new("ABCD") }

    describe "#get_object" do
      it "should get object" do
        subject.faraday.should_receive(:get).and_return({})

        subject.get_object("video", "1234")
      end
    end

    describe "#get_connections" do
      it "should get connections" do
        subject.faraday.should_receive(:get).and_return({})

        subject.get_connections("user", "1234", "videos")
      end
    end

    describe "#get_connection" do
      it "should get connection" do
        subject.faraday.should_receive(:get).and_return({})

        subject.get_connection("user", "1234", "videos")
      end
    end

    describe "#post_video" do
      it "should post video" do
        subject.should_receive(:post_object).and_return({})

        subject.post_video("http://myvideo")
      end
    end

    describe "#post_object" do
      it "should post object" do
        subject.faraday.should_receive(:post).and_return({})

        subject.post_object("video", "1234", { :title => "hello world" })
      end
    end

    describe "#upload_file" do
      it "should upload file" do
        faraday_mock = mock(:faraday)
        Faraday.should_receive(:new).twice.and_return(faraday_mock)
        Faraday::UploadIO.should_receive(:new).and_return({})
        faraday_mock.should_receive(:post).and_return({})

        subject.upload_file("pipomolo.m4v", "http://pipomolo.com")
      end
    end
  end
end
