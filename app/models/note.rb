class Note < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :user
  has_many :note_users

  has_many :category_notes
  has_many :categories, through: :category_notes




  def set_defaults
    self.completed = false if self.completed.nil?
  end
end
