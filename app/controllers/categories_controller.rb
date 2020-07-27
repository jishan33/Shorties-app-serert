class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :show]
  before_action :authenticate_user

  def index
    categories = Category.all.order('name')
    render json:  categories 
  end

  def show
    category_notes = @category.notes.where(user_id: current_user.id)
    notes = category_notes.map do |note|
      note_hash(note)
    end
    render json: { notes: notes }, status: 200
  end

  def note_hash(note)
    note_hash = note.attributes
    note_hash[:categories] = note.categories
    note_hash[:picture] = url_for(note.picture) if note.picture.attached?
    note_hash
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
