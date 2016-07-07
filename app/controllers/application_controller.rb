class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include UsersHelper
	include AnswersHelper

	def authorized_user
    	redirect_to user_path(current_user) unless authorized_user? current_user.type
  	end

	def authorized_user? user
	    @authorized_use = case user
	      when "Teacher" 
	        then true
	      else
	        false                           
	    end 
	end
end
