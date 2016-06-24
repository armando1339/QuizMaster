require 'rails_helper'

RSpec.describe User, type: :model do

	it "has a validation for email presence" do 
		user = User.new(:email => nil, :password => 'ableton10')
		expect(user.save).to be false 
	end

	it "has a validation for password presence" do 
		user = User.new(:email => 'armando1339@gmail.com', :password => nil)
		expect(user.save).to be false
	end

	it "has a validation for type presence" do 
		user = User.new(:email => 'armando1339@gmail.com', :password => 'ableton10', :type => nil)
		expect(user.save).to be false
	end

	it "has a association with Quiz model" do 
		user = User.reflect_on_association(:quizzes)
    	expect(user.macro) == :has_many
	end

	it "has a association with HistoryOfQuiz model" do 
		user = User.reflect_on_association(:history_of_quizzes)
    	expect(user.macro) == :has_many
	end
end
