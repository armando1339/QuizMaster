class Users::HistoryOfQuizzesController < ApplicationController
	before_action :authenticate_user!
	layout 'inside_layout'
	def index
		@user = User.find(current_user.id)
		@history_of_quizzes = @user.history_of_quizzes.all
	end
end