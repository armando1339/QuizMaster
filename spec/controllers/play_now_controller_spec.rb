require 'rails_helper'

RSpec.describe PlayNowController, type: :controller do
	

	describe "POST #evaluate_response" do
		before(:each) do
	    	request.env['HTTP_REFERER'] = answer_question_play_now_index_url
		end
		
    	it "failed request" do
      		post :evaluate_response
      		expect(response).to redirect_to :back
		end

  end

end
