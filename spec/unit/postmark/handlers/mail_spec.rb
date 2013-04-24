require 'spec_helper'

describe Mail::Postmark do
  let(:message) do
    Mail.new do
      from    "sheldon@bigbangtheory.com"
      to      "lenard@bigbangtheory.com"
      subject "Hello!"
      body    "Hello Sheldon!"
    end
  end

  it "can be set as delivery_method" do
    message.delivery_method Mail::Postmark
  end

  it "wraps Postmark.send_through_postmark" do
    Postmark::ApiClient.any_instance.should_receive(:deliver_message).with(message)
    message.delivery_method Mail::Postmark
    message.deliver
  end

  it "allows to set the api key" do
    message.delivery_method Mail::Postmark, {:api_key => 'api-key'}
    message.delivery_method.settings[:api_key].should == 'api-key'
  end
end