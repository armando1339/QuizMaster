class Users::Quizzes::Questions::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorized_user
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  layout 'inside_layout'

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to users_quizzes_question_path(params[type_of_answer(params)][:question_id]), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { 
          @question = Question.find(params[type_of_answer(params)][:question_id])
          render :new 
        }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(type_of_answer(params)).permit(:type, :contect, :question_id)
    end
end
