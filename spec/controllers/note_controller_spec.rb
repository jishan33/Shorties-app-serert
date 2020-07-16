require "rails_helper"

RSpec.describe NotesController, type: :controller do
  it do
    attributes = attributes_for(:note)
    should permit(:title, :body, :public_share, :completed)
        .for(:create, params: { note: attributes })
        .on(:note)
  end
end
