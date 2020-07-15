require 'rails_helper'

RSpec.describe Note, type: :model do
  subject {build(:note)}

  context 'validations' do 
    it 'is valid with valid attritube' do 
      expect(subject).to be_valid
    end 

    it { expect(subject).to validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(2).is_at_most(100) }
    it { expect(subject).to validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(2) }
    it { expect(subject).to validate_inclusion_of(:public_share).in_array([true,false])}
    it { expect(subject).to validate_inclusion_of(:completed).in_array([true,false])}
  end

  context "associations" do 
    it { expect(subject).to have_many(:categories).through(:category_notes) }
    it { expect(subject).to belong_to(:user)}
    it { expect(subject).to have_many(:note_users) }
  end

end
