require 'rails_helper'

RSpec.describe Users::QuizzesController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 		
		allow(controller).to receive(:authorized_user).and_return(true)
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
		@request.env["devise.mapping"] = Devise.mappings[:user]
		sign_in registered_user
		registered_quiz = Quiz.create!(:id => 1, :name => "Math", :description => "Respond properly to the exercises", :user_id => 1)
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
		  	quizzes = Quiz.where('user_id = ?', 1)
		  	get :index
		    expect(assigns(:quizzes)).to match(quizzes)
		end
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
		it 'render new view' do
			get :new
      		expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		it 'render new view' do
			get :edit, :id => 1
      		expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do
		context 'with valid params' do
			before do
          		post :create, quiz: {:id => 2, :name => "Math", :description => "¡Soy la descripción de este quiz!", :user_id => 1}
        	end

        	it 'to creates a quiz' do
        		expect(Quiz.last.name).to eq 'Math'
	          	expect(Quiz.last.description).to eq '¡Soy la descripción de este quiz!'
	        end

	        it 'redirects to the after_create_quiz_url' do
	          	expect(response).to redirect_to users_quiz_path(Quiz.last.id)
	        end
		end

		context "Without valid params" do
			before do
          		post :create, quiz: { :name => nil, :description => "¡Soy la descripción de este quiz!", :user_id => 1}
        	end

        	it { is_expected.to render_template :new }

			it 'returns the invalid question' do
				expect(assigns(:quiz)).to be_present
			end

			it 'render new' do
	          	expect(response).to render_template(:new)
	        end
		end
	end

	describe "DELETE #destroy" do 
		it "deletes the questions" do
		    expect{
		      delete :destroy, id: 1      
		    }.to change(Quiz,:count).by(-1)
		end
		    
		it "redirects to back" do
		    delete :destroy, id: 1
		    expect(response).to redirect_to users_quizzes_path
	  	end
	end

	describe "PUT #update" do
		before do
			put :update, id: 1, quiz: { user_id: 1, :name => "Math 1", :description => "¡Soy el texto nuevo!" }
		end

		it { expect(response).to redirect_to users_quiz_path(1) }
		it "change quiz" do 
			expect(Quiz.find(1).name).to eq "Math 1"
			expect(Quiz.find(1).description).to eq "¡Soy el texto nuevo!" 
		end
	end
end
