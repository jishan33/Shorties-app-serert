require 'rails_helper'

RSpec.describe Cohort, type: :model do
  subject { build (:cohort) }

  context 'validations' do
    it 'has a valid factory' do
      expect(build (:cohort)).to be_valid
    end

    it 'has a name' do 
      expect(subject).to validate_presence_of(:name) 
    end

    it 'has a unique name' do
      expect(subject).to validate_uniqueness_of(:name)
    end
  end

  context 'associations' do
    it { expect(subject).to have_many(:users)}
    it { expect(subject).to have_many(:user_cohorts)}
  end
end
