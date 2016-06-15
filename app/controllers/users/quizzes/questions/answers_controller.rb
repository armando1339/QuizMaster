class Users::Quizzes::Questions::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorized_user
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  layout 'inside_layout'

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    if params['correct'] or params['incorrect']
      @answer = Answer.new(answer_type_params)
    else
      @answer = Answer.new(answer_params)
    end

    respond_to do |format|
      if @answer.save
        if params['correct'] or params['incorrect']
          format.html { redirect_to users_quizzes_question_path(answer_type_params[:question_id]), notice: 'Answer was successfully created.' }
        else
          format.html { redirect_to users_quizzes_question_path(params[:answer][:question_id]), notice: 'Answer was successfully created.' }
        end
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { 
          if params['correct'] or params['incorrect']
            @question = Question.find(answer_type_params[:question_id])
          else
            @question = Question.find(params[:answer][:question_id])
          end
          render :new 
        }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_type_params)
        format.html { redirect_to users_quizzes_question_path(params[:incorrect][:question_id]), notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
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
      params.require(:answer).permit(:type, :contect, :question_id)
    end

    def answer_type_params
      params.require(type_of_answer(params)).permit(:type, :contect, :question_id)
    end
end
