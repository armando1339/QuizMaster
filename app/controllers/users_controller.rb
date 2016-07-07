class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'inside_layout'

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end
end
