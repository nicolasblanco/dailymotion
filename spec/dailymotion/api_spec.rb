require "spec_helper"
require "dailymotion"
require "pry"

describe Dailymotion::API do
  it "should be initialized with an options hash" do
    @api = Dailymotion::API.new(token: "ABCD")

    @api.options[:token].should eq("ABCD")
  end

  describe "with a token" do
    subject { Dailymotion::API.new(token: "ABCD") }

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

  describe "#refresh_token!" do
    it "should fail if client_id, client_secret or refresh_token are not set" do
      @api = Dailymotion::API.new(token: "ABCD")

      expect { @api.refresh_token! }.to raise_error(StandardError)
    end

    describe "with all options" do
      it "should refresh the token" do
        @api = Dailymotion::API.new(client_id: "pipo", client_secret: "molo", refresh_token: "ahah")

        response_mock = mock(:faraday, body: Hashie::Mash.new(access_token: "new_token"))
        @api.faraday_post.should_receive(:post).and_return(response_mock)
        @api.should_receive(:set_faradays).once

        @api.refresh_token!
        @api.options[:token].should eq("new_token")
      end
    end
  end
end
