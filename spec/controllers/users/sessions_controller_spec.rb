require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
	before(:each) do
      	@request.env["devise.mapping"] = Devise.mappings[:user]
      	User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
    end

    describe 'GET #new' do
		it 'render new view' do
			get :new
      		expect(response).to render_template :new
		end
	end

    describe 'POST #create' do
	    context "when password is INCORRECT" do
			before(:each) do
				post :create, user: { email: 'armando1339@gmail.com', password: 'nada de nada' }
			end
			it { expect(response).to be_success }
			it { expect(flash[:alert]).to eq('Invalid Email or Password.') }
	  	end

	  	context "when password is CORRECT" do
			before(:each) do
				post :create, user: { email: 'armando1339@gmail.com', password: 'ableton10' }
			end
			it { expect(flash[:notice]).to eq('Signed in successfully.') }
			it { expect(response).to redirect_to user_path(1) }
	  	end
	end

	describe "DELETE #destroy" do 
		it "redirects to back" do
		    delete :destroy
		    expect(response).to redirect_to "/"
	  	end
	end
end
