class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable#, :confirmable
	has_many :quizzes, dependent: :destroy
end

class Teacher < User
end 

class Student < User
end