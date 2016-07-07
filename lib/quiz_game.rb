class QuizEvaluator
	attr_accessor :question, :answer

	def initialize question=nil, answer=nil
			@build[:perfil] =  { @question => question,
			@answer => answer} 
	end 

	def self.build
		@build
	end

	def evaluate
		if params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') == "0" or params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') == "zero"
			# comparing a response as a string of numbers
			if @answer.contect.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') 
				session[:number_of_correct_answers] += 1
			# comparing a response as a number in characters
			elsif @answer.contect.to_i.humanize.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ')
				session[:number_of_correct_answers] += 1 if @answer.contect.index(/[a-zA-Z]/) == nil # validate dont'n exis to_i problem
			end
			session[:number_of_question] += 1
		end

	end

end 
