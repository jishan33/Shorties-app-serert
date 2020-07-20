class Note < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  validates :title, presence: true
  validates_length_of :title, in: 2..100
  validates :body, presence: true
  validates_length_of :body, minimum: 2

  validates :public_share, inclusion: [true, false] 
  validates :completed, inclusion: [true, false] 
  
  belongs_to :user

  has_many :note_users, dependent: :delete_all
  has_many :users, through: :note_users

  has_many :category_notes, dependent: :delete_all, validate: false
  has_many :categories, through: :category_notes

  has_many_attached :pictures




  def set_defaults
    self.completed = false if self.completed.nil?
    self.public_share = false if self.public_share.nil?
  end
end
