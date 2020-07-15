class Category < ApplicationRecord
  validates :name, presence: true
  validates_length_of :name , in: 5..35
  
  has_many :category_notes
  has_many :notes, through: :category_notes
end
