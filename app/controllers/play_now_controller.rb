class PlayNowController < ApplicationController
	before_action :authenticate_user!
	layout 'inside_layout'

	# this method start the quiz and all variables needed
	def start_quiz
		@quiz = Quiz.find(params[:id])
		session[:quiz_loaded] = @quiz
		session[:questions] = @quiz.questions
		session[:number_of_question] = 0
		session[:number_of_correct_answers] = 0
		@quiz
	end

	# this method navigate between all questions
	def answer_question
		session[:difficulty] = params[:difficulty] if params[:difficulty]
		if session[:questions][session[:number_of_question].to_i] == nil
			redirect_to result_of_quiz_play_now_index_path
		else
			@question = Question.find(session[:questions][session[:number_of_question].to_i]["id"])
		end
	end

	# evaluates a client response
	def evaluate_response 
		# evaluation difficulty: hard 
		if params["answer"]
			# =>  find question and correct answer for it
			@question = Question.find(session[:questions][session[:number_of_question].to_i]["id"])
			@answer = @question.answers.find_by('type = ?', 'Correct')
			#
			# =>  evaluate when is "0" or "zero"
			if params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') == "0" or params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') == "zero"
				# comparing a response as a string of numbers
				if @answer.contect.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') 
					session[:number_of_correct_answers] += 1
				# comparing a response as a number in characters
				elsif @answer.contect.to_i.humanize.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ')
					session[:number_of_correct_answers] += 1 if @answer.contect.index(/[a-zA-Z]/) == nil # validate dont'n exis to_i problem
				end
				session[:number_of_question] += 1
				redirect_to answer_question_play_now_index_path
			#
			# =>  evaluate blank answer
			elsif params["answer"].blank?
				redirect_to :back, notice: 'Please type an answer.'
			#
			# evaluate when is diferent to "0" or "zero"
			elsif params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') != "0" or params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') != "zero"
				# comparing a response as a string of numbers
				if @answer.contect.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ') 
					session[:number_of_correct_answers] += 1
				# comparing a response as a number in characters
				elsif @answer.contect.to_i.humanize.downcase.squeeze.strip.gsub(/-/, ' ') == params["answer"].downcase.squeeze.strip.gsub(/-/, ' ')
					session[:number_of_correct_answers] += 1 if @answer.contect.index(/[a-zA-Z]/) == nil # validate dont'n exis to_i problem
				end
				session[:number_of_question] += 1
				redirect_to answer_question_play_now_index_path

			end	
		# evaluation difficulty: easy
		else
			if params["answer_id"]
				@question = Question.find(session[:questions][session[:number_of_question].to_i]["id"])
				@answer = @question.answers.find(params["answer_id"])
				if @answer.type == 'Correct'
					session[:number_of_correct_answers] += 1
				end
				session[:number_of_question] += 1
				redirect_to answer_question_play_now_index_path
			else
				redirect_to :back, notice: 'Please choose an answer.'
			end
		end
	end

	# this will build a simple result for the client
	def result_of_quiz
		@history_of_quiz = HistoryOfQuiz.new(:user_id => current_user.id, :quiz_id => session[:quiz_loaded]["id"].to_i, :name => session[:quiz_loaded]["name"], :number_of_question => session[:questions].count, :number_of_correct_answers => session[:number_of_correct_answers])
		@history_of_quiz.save
		# build result
		@result = Hash.new
		@result[:message] = "The quiz is finished"
		@result[:quiz] = session[:quiz_loaded]
		@result[:number_of_questions] = session[:questions].count
		@result[:number_of_correct_answers] = session[:number_of_correct_answers]
		# clear session
		session.delete(session[:quiz_loaded])
		session.delete(session[:questions])
		session.delete(session[:number_of_question])
		session.delete(session[:number_of_correct_answers])
		session.delete(session[:difficulty])
		# result content
		@result
	end
end