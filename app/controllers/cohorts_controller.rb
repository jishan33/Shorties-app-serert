class CohortsController < ApplicationController
  before_action :set_cohort, only: %i[show update destroy remove_student]
  before_action :authenticate_user, only: %i[create update destroy remove_student cohorts_students]

  # add authentication in the create to limit that only user (is_teacher true ) can do the create and update and delete
  def index
    cohorts = Cohort.all
    render json: { cohorts: cohorts }, status: 200
  end

  def create
    if cohort_params[:user_emails]
      coh_users = cohort_params[:user_emails].map { |email| User.find_by_email(email) }
      cohort = current_user.cohorts.create({ name: cohort_params[:name] })
      cohort.users = coh_users
    else
      cohort = current_user.cohorts.create({ name: cohort_params[:name] })
    end

    if cohort.save
      render json: { cohort: cohort }, status: :created, include: :users
    else
      render json: { errors: cohort.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @cohort, include: :users
  end

  def cohorts_students
    cohort = Cohort.find_by(user: current_user)

    if cohort.nil?
      render json: []
    else
      all_students = cohort.users
      render json: { all_students: all_students }
    end
  end

  def update
    @cohort.user = current_user
    if @cohort.update(cohort_params)
      render json: "cohort updated", status: :no_content
    else
      render json: { errors: @cohort.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @cohort.destroy
    render json: "cohort deleted", status: :no_content
  end

  def remove_student
    user = User.find(params[:user_id])
    @cohort.users.delete(user)
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, user_emails: [])
  end

  def set_cohort
    @cohort = Cohort.includes(:users).find(params[:id])
  end
end
