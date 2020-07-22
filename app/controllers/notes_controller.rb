class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :authenticate_user

  def index   
   #notes = current_user.notes.includes(:categories).all.order(id: "asc")
    notes = current_user.notes.with_attached_picture.includes(:categories)
    render json: { notes: generate_picture_urls(notes) }, status: 200, include: :categories

  end

  def create
  # get the whole object of the found categories   
    categories = JSON.parse(note_params[:category_ids]).map { |id| Category.find(id) }
    
    note = current_user.notes.create(note_params.except(:category_ids))

    #put the categories on the note and rails will create the join table
    note.categories = categories

    if note.save

      if note_params[:picture]
        render json: { note: note, picture: url_for(note.picture) }, status: 201
      else
        render json: { note: note, picture: "" }, status: 201, include: :categories
      end

    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @note, include: :categories
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

  def update_picture
    @note.picture.purge
    @note.picture.attach(note_params[:picture])
    render json: url_for(@note.picture)
  end


  private

  def note_params
    params
      .require(:note).permit(:title, :body, :completed, :public_share, :picture, :category_ids)
  end

  def set_note
    @note = Note.includes(:categories).find(params[:id])
  end

  def generate_picture_urls(notes)
    notes.map do |note|
      if note.picture.attached?
        note.attributes.merge(picture: url_for(note.picture))
      else
        note
      end
    end
  end


end
