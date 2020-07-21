class NotesController < ApplicationController
  before_action :set_note, only: [:show, :show_categories, :update, :destroy]
  before_action :authenticate_user

  def index
    notes = current_user.notes.all.order(id: "asc")
    render json: notes, status: 200
  end

  def create
  # get the whole object of the found categories
    categories = note_params[:category_ids].map { |id| Category.find(id) }
    
    note = current_user.notes.create(note_params.except(:category_ids))

    #put the categories on the note and rails will create the join table
    note.categories = categories

    if note.save
      render json: note, status: 201
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @note
  end

  def show_categories
    render json: @note.categories
  end

  def update
    if @note.update(note_params)
      render json: "Post updated", status: :no_content
    else
      render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    render json: "post deleted", status: :no_content
  end

  private

  def note_params
    params
      .require(:note).permit(:title, :body, :completed, :public_share, :pictures, category_ids: [])
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
