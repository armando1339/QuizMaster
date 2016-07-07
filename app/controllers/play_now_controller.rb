class PlayNowController < ApplicationController
	include QuizzesHelper
	before_action :authenticate_user!
	layout 'inside_layout'

	# Start the quiz and all variables needed (loading the session)
	def start_quiz
		@quiz = Quiz.find(params[:id])
		session[:quiz_loaded] = @quiz
		session[:questions] = @quiz.questions
		session[:number_of_question] = 0
		session[:number_of_correct_answers] = 0
		@quiz
	end

	# this method navigate between all questions collecting results
	def answer_the_question
		session[:difficulty] = params[:difficulty] if params[:difficulty]
		if session[:questions][session[:number_of_question].to_i] == nil
			redirect_to result_of_quiz_play_now_index_path
		else
			@question = Question.find(session[:questions][session[:number_of_question].to_i]["id"])
		end
	end

	# evaluates a client response
	def evaluate_response 
		@question = Question.find(session[:questions][session[:number_of_question].to_i]["id"])

		# => evaluation for mode: hard 
		if params["answer"] 
			@answer = @question.answers.find_by('type = ?', 'Correct')

			if params["answer"].blank?
				redirect_to :back, notice: 'Please type an answer.'
			else
				session[:number_of_correct_answers] += 1 if evaluate_number_or_string(@answer, params["answer"])
				session[:number_of_question] += 1
				redirect_to answer_the_question_play_now_index_path
			end	

		# => evaluation for mode: easy
		else 
			if params["answer_id"].blank?
				redirect_to :back, notice: 'Please choose an answer.'
			else
				@answer = @question.answers.find(params["answer_id"]) 
				session[:number_of_correct_answers] += 1 if basic_evaluate(@answer)
				session[:number_of_question] += 1
				redirect_to answer_the_question_play_now_index_path
			end
		end
	end

	# Build a result for the client and ending the session
	def result_of_quiz
		# => build result
		HistoryOfQuiz.create!(:user_id => current_user.id, :quiz_id => session[:quiz_loaded]["id"].to_i, :name => session[:quiz_loaded]["name"], :number_of_question => session[:questions].count, :number_of_correct_answers => session[:number_of_correct_answers])
		@result = build_result session[:quiz_loaded], session[:questions].count, session[:number_of_correct_answers], "The quiz is finished"
		# => clear session
		session.delete(session[:quiz_loaded])
		session.delete(session[:questions])
		session.delete(session[:number_of_question])
		session.delete(session[:number_of_correct_answers])
		session.delete(session[:difficulty])
	end
end