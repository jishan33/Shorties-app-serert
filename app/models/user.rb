class User < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_secure_password
  validates :email, presence: true

  has_many :note_users
  has_many :notes

  def set_defaults
    self.is_teacher = false if self.is_teacher.nil?
  end
end
