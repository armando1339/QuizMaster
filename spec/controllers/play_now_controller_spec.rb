require 'rails_helper'

RSpec.describe PlayNowController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		@request.env["devise.mapping"] = Devise.mappings[:user]
		sign_in registered_user
		registered_quiz = Quiz.create!(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		registered_question = Question.create!(:id => 1, :contect => "Respond properly to the exercises", :quiz_id => 1)
		question = Question.find(1)		
	end

	describe "POST #evaluate_response" do
		before(:each) do
	    	request.env['HTTP_REFERER'] = '/'
		end

    	it "failed request" do
      		post :evaluate_response, answer: "one"
      		expect(response).to redirect_to :back
		end
  	end
end
