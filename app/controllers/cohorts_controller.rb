class CohortsController < ApplicationController
  before_action :set_cohort, only: [:show, :update, :destroy]
   before_action :authenticate_user, only: %i[create update destroy]

  # add authentication in the create to limit that only user (is_teacher true ) can do the create and update and delete
  def index
    cohorts = Cohort.all
    render json: { cohorts: cohorts }, status: 200
  end

  def create
    cohort = Cohort.new(cohort_params)
    cohort.user = current_user
    if cohort.save
      render json: { cohort: cohort }, status: :created
    else
      render json: { errors: cohort.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @cohort 
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
    @cohort.delete
    render json: "cohort deleted", status: :no_content
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end

  def set_cohort
    @cohort = Cohort.find(params[:id])
  end
end
