class Answer < ActiveRecord::Base
	include ActiveModel::Validations
	belongs_to	:question
	validates 	:type, :contect, presence: true
	validate 	:only_one_correct_answer

	private

		def only_one_correct_answer
			if self.type == 'Incorrect' or self.type.blank?
				# nothing
			else
				@question = Question.find(self.question_id)
				@answers = @question.answers.all
				@count = 0
				@answers.each do |a|
					if a.type == "Correct"
						@count += 1
					end
				end
				if @count >= 1
					errors.add(:only_one_correct_answer, "can be saved")
				end
			end
		end
end

class Correct < Answer
end 

class Incorrect < Answer
end
