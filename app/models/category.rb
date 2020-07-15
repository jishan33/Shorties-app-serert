class Category < ApplicationRecord
  has_many :category_notes
  has_many :notes, through: :category_notes
end
