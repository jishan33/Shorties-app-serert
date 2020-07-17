class User < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_secure_password
  # validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :email, presence: true,
            format: { with: /(.+)@(.+)/, message: "Invalid email"  }, 
            uniqueness: true 
            
  has_many :note_users, dependent: :delete_all
  has_many :shared_notes, through: :note_users, class_name: "Note"
  has_many :notes


  
  has_many :user_cohorts, dependent: :delete_all
  has_many :cohort_classes, through: :user_cohorts, class_name: "Cohort"

  has_many :cohorts 

  

  def set_defaults
    self.is_teacher = false if self.is_teacher.nil?
  end
end
