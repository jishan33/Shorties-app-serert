require 'rails_helper'

RSpec.describe Note, type: :model do
  subject {build(:note)}

  context 'validations' do 
    it 'is valid with valid attritube' do 
      expect(subject).to be_valid
    end 
  end
end
