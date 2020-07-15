class Note < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  validates :title, presence: true
  validates :body, presence: true
  validates :public_share, inclusion: [true, false] 
  validates :completed, inclusion: [true, false] 






  belongs_to :user
  has_many :note_users

  has_many :category_notes
  has_many :categories, through: :category_notes




  def set_defaults
    self.completed = false if self.completed.nil?
    self.public_share = false if self.public_share.nil?
  end
end
