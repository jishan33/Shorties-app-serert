require 'rails_helper'

RSpec.describe CategoryNote, type: :model do
  context "validation" do 
    it "has a valid factory" do 
      expect(build(:category_note)).to be_valid
    end
  end

  context "associations" do
    it { should belong_to(:category) }
    it { expect(subject).to belong_to(:note)}
  end

end
