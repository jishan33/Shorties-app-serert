class CategoriesController < ApplicationController
  before_action :find_category, only: [:update]

  def index
    categories = Category.all
    render json: { categories: categories }
  end

  def create
    return_categories = []
    categories_params.each { |c|
      category = Category.find_by(name: c[:name])
      category = Category.create(c) if category.nil?

      return_categories << category
    }

    render json: return_categories, status: 201
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

  def categories_params
    params.require(:categories).map { |c| c.permit(:name) }
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
