require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	before do
		allow(controller).to receive(:authenticate_user!).and_return(true) 		
		registered_user = User.create!(:id => 1, :email => 'armando1339@gmail.com', :password => 'ableton10', :type => "Teacher")
	end

	describe 'GET #show' do
		before do
      		get :show, id: 1
    	end
		it 'render show view' do
			expect(response).to render_template :show 
		end
	end
end
