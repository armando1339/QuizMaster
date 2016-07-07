module AnswersHelper
	def answer_type_options
		@options = Answer.subclasses_array_options
	end

	def type_of_answer params=nil
		return nil if params == nil
		@answer_subclasses = answer_type_options
		@answer_subclasses.each do |t|
			if params[t.underscore.to_sym]
				@type_of_answer = t.underscore.to_sym
				break
			else
				@type_of_answer = "Answer".underscore.to_sym
			end
		end
		@type_of_answer 
	end
end
