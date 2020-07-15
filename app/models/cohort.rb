class Cohort < ApplicationRecord
  belongs_to :user,  -> { where is_teacher: true }
  has_many :user_cohorts
  has_many :users, through: :user_cohorts

 
end
