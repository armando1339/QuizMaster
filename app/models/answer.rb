class Answer < ActiveRecord::Base
	belongs_to	:question
	validates 	:type, :contect, :question_id, presence: true
	validate 	:only_one_correct_answer

	class << self
		def subclasses_array_options
			@answer_type_options = Array.new
			@types = Answer.subclasses
			@types.each do |t|
				@answer_type_options << t.to_s
			end 
			@answer_type_options
		end
	end

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

class Correct < Answer; end 
class Incorrect < Answer; end
