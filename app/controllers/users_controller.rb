class UsersController < ApplicationController
  before_action :authenticate_user!

  # @route GET /users/:id (user)
  def show
    @user = User.find(params[:id])
  end
end
