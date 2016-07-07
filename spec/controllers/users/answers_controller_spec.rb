require 'rails_helper'

RSpec.describe Users::Quizzes::Questions::AnswersController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 		
		allow(controller).to receive(:authorized_user).and_return(true)
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_quiz = Quiz.create!(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		registered_question = Question.create!(:id => 1, :contect => "Respond properly to the exercises", :quiz_id => 1)
	end

	describe 'GET #new' do
		it 'Render new view' do
			get :new
      		expect(response).to render_template('new')
		end
	end

	describe 'POST #create' do
		context 'with valid params' do
			before do
          		post :create, answer: { :type => 'Correct', :contect => '¡Soy el contenido!', :question_id => 1}
        	end

        	it 'creates a correct answer for the question' do
	          	expect(Answer.last.type).to eq 'Correct'
	          	expect(Answer.last.contect).to eq '¡Soy el contenido!'
	        end

	        it 'redirects to the after_create_answer_url' do
	          	expect(response).to redirect_to users_quizzes_question_path(1)
	        end
		end

		context "Without valid params" do
			before do
          		post :create, answer: { :type => 'Correct', :contect => nil, :question_id => 1}
        	end

			it 'returns the invalid answer' do
				expect(assigns(:answer)).to be_present
			end

			it { is_expected.to render_template :new }

			it 'render new' do
	          	expect(response).to render_template(:new)
	        end
		end
	end 

	describe "DELETE #destroy" do 
		before do
			@request.env['HTTP_REFERER'] = 'http://localhost:3000/users/quizzes/questions'
			registered_answer = Answer.create!(:id => 1, :type => "Correct", :contect => "5", :question_id => 1)
  		end
		it "deletes the answers" do
		    expect{
		      delete :destroy, id: 1       
		    }.to change(Answer,:count).by(-1)
		end
		    
		 it "redirects to back" do
		    delete :destroy, id: 1
		    expect(response).to redirect_to :back
	  	end
	end
end
