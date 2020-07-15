require 'rails_helper'

RSpec.describe NoteUser, type: :model do
  context "validation" do
    it "has a valid factory" do
      expect(build(:note_user)).to be_valid
    end
  end

  context "associations" do
    it { should belong_to(:note) }
    it { expect(subject).to belong_to(:user)}
  end
  
end
