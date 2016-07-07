class Question < ActiveRecord::Base
	belongs_to	:quiz
	has_many 	:answers, dependent: :destroy
	validates 	:contect, :quiz_id, presence: true
end
