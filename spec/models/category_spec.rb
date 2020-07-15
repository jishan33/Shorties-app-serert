require "rails_helper"

RSpec.describe Category, type: :model do
  subject { build(:category) }

  context "validation" do
    it "has a valid factory" do
      expect(build(:category)).to be_valid
    end

    it { expect(subject).to validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(35) }
    it { expect(subject).to validate_uniqueness_of(:name) }
  end

  context "associations" do
    it { expect(subject).to have_many(:notes).through(:category_notes) }
  end
end
