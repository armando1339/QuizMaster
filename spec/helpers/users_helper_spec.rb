require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#user_type_options' do
		context 'In form of catalog, for views,' do
		    it 'returns array with answer subclasses' do
		      	expect(helper.user_type_options).to eq ['Teacher', 'Student']
		    end
		end
	end
end
