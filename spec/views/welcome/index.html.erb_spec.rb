require File.expand_path("../../../spec_helper", __FILE__)

describe "welcome/index.html.erb" do
	before(:each) do
		@message = stub("Message")
		assigns[:message] = @message
	end

	it "should display the text of the message" do
		@message.stub!(:text).and_return "Welcome"
		render "welcome/index.html.erb"
		response.should contain("Welcome")
	end
end