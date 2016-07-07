require 'rails_helper'

RSpec.describe Users::HistoryOfQuizzesController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 		
		allow(controller).to receive(:authorized_user).and_return(true)
		@request.env["devise.mapping"] = Devise.mappings[:user]
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		sign_in registered_user
	end

	describe "GET #index" do
		it "responds successfully with an HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
		  	get :index
		  	expect(response).to render_template("index")
		end

		it "loads all quizzes that belong to a user" do
		  	registered_quiz_1 = HistoryOfQuiz.create!(:id => 1, :user_id => 1, :quiz_id => 1, :name => "Math", :number_of_question => 5, :number_of_correct_answers => 2 )
			registered_quiz_2 = HistoryOfQuiz.create!(:id => 2, :user_id => 1, :quiz_id => 1, :name => "Math", :number_of_question => 7, :number_of_correct_answers => 4 )
		  	get :index
		    expect(assigns(:history_of_quizzes)).to match_array([registered_quiz_1, registered_quiz_2])
		end
	end

end
