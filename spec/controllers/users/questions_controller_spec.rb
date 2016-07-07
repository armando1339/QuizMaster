require 'rails_helper'

RSpec.describe Users::Quizzes::QuestionsController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 		
		allow(controller).to receive(:authorized_user).and_return(true)
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		registered_quiz = Quiz.create!(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
		registered_question = Question.create!(:id => 1, :contect => "Respond properly to the exercises", :quiz_id => 1)
	end

	describe 'GET #show' do
		before do
      		get :show, :id => 1
    	end
		it 'render show view' do
			expect(response).to render_template :show 
		end
	end

	describe 'GET #new' do
		it 'Render new view' do
			get :new
      		expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		it 'Render new view' do
			get :edit, :id => 1
      		expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do
		context 'with valid params' do
			before do
          		post :create, question: { :contect => "¡Soy el contenido de question!", :quiz_id => 1}
        	end

        	it 'to creates a question' do
	          	expect(Question.last.contect).to eq '¡Soy el contenido de question!'
	        end

	        it 'redirects to the after_create_question_url' do
	          	expect(response).to redirect_to users_quiz_path(1)
	        end
		end

		context "Without valid params" do
			before do
          		post :create, question: { :contect => nil, :quiz_id => 1}
        	end

        	it { is_expected.to render_template :new }

			it 'returns the invalid question' do
				expect(assigns(:question)).to be_present
			end

			it 'render new' do
	          	expect(response).to render_template(:new)
	        end
		end
	end

	describe "DELETE #destroy" do 
		it "deletes the questions" do
		    expect{
		      delete :destroy, id: 1, quiz_id: 1      
		    }.to change(Question,:count).by(-1)
		end
		    
		it "redirects to back" do
		    delete :destroy, id: 1, quiz_id: 1
		    expect(response).to redirect_to users_quiz_path(1)
	  	end
	end

	describe "PUT #update" do
		before do
			put :update, id: 1, question: { quiz_id: 1, contect: "¡Soy el texto nuevo!" }
		end

		it { expect(response).to redirect_to users_quiz_path(1) }
		it { expect(Question.find(1).contect).to eq "¡Soy el texto nuevo!" }
	end
end
