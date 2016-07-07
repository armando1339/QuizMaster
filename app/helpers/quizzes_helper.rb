module QuizzesHelper

	def evaluate_number_or_string answer, player_answer
		if player_answer.downcase.squeeze.strip.gsub(/-/, ' ') == "0" or player_answer.downcase.squeeze.strip.gsub(/-/, ' ') == "zero"
			if answer.contect.downcase.squeeze.strip.gsub(/-/, ' ') == player_answer.downcase.squeeze.strip.gsub(/-/, ' ') 
				return true
			elsif answer.contect.to_i.humanize.downcase.squeeze.strip.gsub(/-/, ' ') == player_answer.downcase.squeeze.strip.gsub(/-/, ' ')
				if answer.contect.index(/[a-zA-Z]/) == nil # validate dont'n exis to_i problem
					return true 
				end
			else
				return false
			end
		else player_answer.downcase.squeeze.strip.gsub(/-/, ' ') != "0" or player_answer.downcase.squeeze.strip.gsub(/-/, ' ') != "zero"
			if answer.contect.downcase.squeeze.strip.gsub(/-/, ' ') == player_answer.downcase.squeeze.strip.gsub(/-/, ' ') 
				return true
			elsif answer.contect.to_i.humanize.downcase.squeeze.strip.gsub(/-/, ' ') == player_answer.downcase.squeeze.strip.gsub(/-/, ' ') 
				if answer.contect.index(/[a-zA-Z]/) == nil # validate dont'n exis to_i problem
					return true
				end
			else
				return false
			end
		end
	end

	def basic_evaluate answer
		return false if answer == nil
		if answer.type == 'Correct'
			return true 
		else
			return false
		end
	end

	def build_result quiz_loaded, number_of_questions, number_of_correct_answers, message
		@result = Hash.new
		@result[:message] = "The quiz is finished"
		@result[:quiz] = session[:quiz_loaded]
		@result[:number_of_questions] = session[:questions].count
		@result[:number_of_correct_answers] = session[:number_of_correct_answers]
		@result
	end
end
