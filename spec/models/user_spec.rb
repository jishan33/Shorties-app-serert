require "rails_helper"

RSpec.describe User, type: :model do
  subject { build (:user) }

  context "validations" do
    it "has a valid factory" do
      expect(build (:user)).to be_valid
    end

    it "has an email" do
      expect(subject).to validate_presence_of(:email)
    end

    it "has a unique email" do
      expect(subject).to validate_uniqueness_of(:email)
    end

    it "has a valid email" do
      expect(subject).to_not allow_value("blah").for(:email)
    end

    it "has secure password" do
      expect(subject).to have_secure_password
    end
  end

  context "associations" do
    it { expect(subject).to have_many(:cohorts) }
    it { expect(subject).to have_many(:cohort_classes).through(:user_cohorts) }

    it { expect(subject).to have_many(:notes) }
    it { expect(subject).to have_many(:shared_notes).through(:note_users) }
  end
end
