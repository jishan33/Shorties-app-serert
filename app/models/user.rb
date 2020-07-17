class User < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_secure_password
  # validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, presence: true,
            format: { with: /(.+)@(.+)/, message: "Invalid email"  }, 
            uniqueness: true 
            
  has_many :note_users
  has_many :notes, through: :note_users
  
  has_many :user_cohorts
  has_many :cohorts, through: :user_cohorts

  def set_defaults
    self.is_teacher = false if self.is_teacher.nil?
  end
end
