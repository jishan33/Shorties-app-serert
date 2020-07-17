class UsersController < ApplicationController
  before_action :find_user, only: [:update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy]
   def create
    user = User.new(user_params)
    if user.save
      render json: {}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {}, status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end 
  end

  def destroy
    if @user.destroy
      render json: {}, status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end 
  end

  private 

  def user_params 
    params.require(:user).permit(:email, :password, :username, :is_teacher)
  end 
end
