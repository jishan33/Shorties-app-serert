class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :authenticate_user

  def index
    #notes = current_user.notes.includes(:categories).all.order(id: "asc")
    notes = current_user.notes.map do |note|
      note_hash(note)
    end

    render json: { notes: notes }, status: 200
  end

  def create
    if note_params[:category_ids].nil?
      note = current_user.notes.create(note_params.except(:category_ids))
    else
      # get the whole object of the found categories
      categories = JSON.parse(note_params[:category_ids]).map { |id| Category.find(id) }
      note = current_user.notes.create(note_params.except(:category_ids))

      #put the categories on the note and rails will create the join table
      note.categories = categories
    end

    if note.save
      if note_params[:picture]
        render json: { note: note_hash(note), picture: url_for(note.picture) }, status: 201
      else
        render json: { note: note_hash(note), picture: "" }, status: 201
      end
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @note
  end

  def update
    categories_list = JSON.parse(note_params[:categories_attributes])

    categories = categories_list.map { |c|
      Category.find_by(name: c["name"]) || Category.create(c)
    }
    if @note.update(note_params.except(:categories_attributes, :picture))
      @note.categories = categories

      update_picture(@note)

      render json: note_hash(@note), status: 200
    else
      render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def note_hash(note)
    note_hash = note.attributes
    note_hash[:categories] = note.categories
    note_hash[:picture] = url_for(note.picture) if note.picture.attached?
    note_hash
  end

  def destroy
    @note.destroy
    render json: "post deleted", status: :no_content
  end

  def update_picture(note)
    return if !note.picture.attached? && note[:picture].nil?
    return if note.picture.attached? && url_for(note.picture) == note_params[:picture]

    note.picture.attach(note_params[:picture])
  end

  private

  def note_params
    params
      .require(:note).permit(:title, :body, :completed, :public_share, :picture, :category_ids, :categories_attributes)
  end

  def set_note
    @note = Note.includes(:categories).find(params[:id])
  end
end
