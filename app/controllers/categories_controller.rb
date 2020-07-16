class CategoriesController < ApplicationController
  
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

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
