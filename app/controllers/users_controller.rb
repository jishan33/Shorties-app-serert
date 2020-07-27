class UsersController < ApplicationController
  before_action :find_user, only: [:update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy, :index]

  def index
    users = User.all
    render json: { users: users }, status: 200
  end

  def create
    if !verify_recaptcha(response: user_params[:recaptcha_token])
      render json: { error: "Invalid recaptcha token" }, status: 401
      return
    end

    user = User.new(user_params.except(:recaptcha_token))
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
    if @user.id = current_user.id
      @user.destroy
      render json: "User deleted", status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :is_teacher, :recaptcha_token)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
