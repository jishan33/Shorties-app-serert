class NotesController < ApplicationController
  def index 
    notes = Note.all
    render json: {notes: notes}, status: 200
  end 
end
