class Cohort < ApplicationRecord
  has_many :user_cohorts
  has_many :users, through: :user_cohorts
  belongs_to :user, -> { where is_teacher: true }

  validates :name, presence: true, uniqueness: true
end
