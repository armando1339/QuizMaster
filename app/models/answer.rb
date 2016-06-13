class Answer < ActiveRecord::Base
	belongs_to	:question
end

class Correct < Answer
end 

class Incorrect < Answer
end
