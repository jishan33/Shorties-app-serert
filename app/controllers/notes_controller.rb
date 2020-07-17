class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: %i[create update destroy]

  def index
    notes = Note.all
    render json: { notes: notes }, status: 200
  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    if note.save
      render json: {}, status: :created
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @note
  end

  def update
    if @note.update(note_params)
      render json: "Post updated", status: :no_content
    else
      render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @note.delete
    render json: "post deleted", status: :no_content
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, :completed, :public_share)
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
