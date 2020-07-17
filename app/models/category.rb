class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_length_of :name , in: 2..35

  has_many :category_notes, dependent: :delete_all 
  has_many :notes, through: :category_notes
end
