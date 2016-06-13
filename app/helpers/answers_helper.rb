module AnswersHelper
	def answer_type_options
		@answer_type_options = Array.new
		@types = Answer.subclasses
		@types.each do |t|
			@answer_type_options << t.to_s
		end 
		@answer_type_options
	end

	def type_of_answer params
		@answer_subclasses = answer_type_options
		@answer_subclasses.each do |t|
			if params[t.underscore.to_sym]
				@type_of_answer = t.underscore.to_sym
				break
			end
		end
		@type_of_answer 
	end
end
