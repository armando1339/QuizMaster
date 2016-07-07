 class User < ActiveRecord::Base
	devise 		:database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	validates 	:type, presence: true
	validates 	:type, inclusion: { in: %w(Teacher Student) }
	has_many 	:quizzes, dependent: :destroy
	has_many 	:history_of_quizzes, dependent: :destroy
	validates_associated :quizzes, :history_of_quizzes

	class << self
		def subclasses_array_options
			@user_type_options = Array.new
			@types = User.subclasses
			@types.each do |t|
				@user_type_options << t.to_s
			end 
			@user_type_options
		end
	end
end

class Teacher < User; end 
class Student < User; end