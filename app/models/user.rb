class User < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_secure_password
  # validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, presence: true,
            format: { with: /(.+)@(.+)/, message: "Email invalid"  }, 
            uniqueness: true 
            
  has_many :note_users

  has_many :shared_notes, through: :note_users, class_name: "Note"
  has_many :notes
  
  has_many :user_cohorts
  has_many :cohorts, through: :user_cohorts

  def set_defaults
    self.is_teacher = false if self.is_teacher.nil?
  end
end
