require 'rails_helper'

RSpec.feature "Answers", type: :feature do
	scenario "user creates a new answer for one of its quiz questions" do
		visit new_users_quizzes_questions_answer_path
	      	#fill_in 'Email', :with => 'user@example.com'
	      	#fill_in 'Contect', :with => 'password'
	    click_button 'Add'
	    expect(page).to have_content 'Success'

	end
end
