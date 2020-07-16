class CategoriesController < ApplicationController
  before_action :find_category, only: [:update]
  def index
    categories = Category.all
    render json: { categories: categories }
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: {}, status: :created
    else
      render json: { errors: category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: {}, status: :no_content
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
