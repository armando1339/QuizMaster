class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable#, :confirmable
	validates :type, presence: true
	has_many :quizzes, dependent: :destroy
	has_many :history_of_quizzes, dependent: :destroy
end

class Teacher < User
end 

class Student < User
end