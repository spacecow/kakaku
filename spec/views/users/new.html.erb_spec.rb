require File.expand_path('../../../spec_helper', __FILE__)

describe "users/new.html.erb" do
	before(:each) do
		errors_stub = stub("errors").as_null_object 
		@user = mock_model( User, :null_object => true, :errors => errors_stub ).as_new_record
		assigns[:user] = @user
	end

	it "should render a form to create a user" do
		render "users/new.html.erb"
		response.should have_selector("form[method=post]", :action => users_path) do |form|
			form.should have_selector("input[type=submit]")
		end
		p @user[:errors]
	end
	
#	it "should render a text field for the user's username" do
#		@user.stub!( :username ).and_return "the username"
#		render "users/new.html.erb"
#		response.should have_selector( "form" ) do |form|
#			form.should have_selector( "input",
#				:name => "user[username]",
#				:value => "the username"
#			)
#		end
#	end
end