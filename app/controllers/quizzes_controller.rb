class QuizzesController < ApplicationController
  before_action :authenticate_user!
  layout 'inside_layout'

  # GET /quizzes
  # GET /quizzes.json
  def index
    # @quizzes = Quiz.all
    @filterrific = initialize_filterrific(Quiz,params[:filterrific])
    @quizzes = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
