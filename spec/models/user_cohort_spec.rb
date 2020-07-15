require 'rails_helper'

RSpec.describe UserCohort, type: :model do
  subject { build(:user_cohort) }
  context 'validations' do
    it 'has a valid factory' do
      expect(build(:user_cohort)).to be_valid
    end
  end

  context 'associations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:cohort) }
  end
end
