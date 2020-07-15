class UserCohort < ApplicationRecord
  belongs_to :cohort
  belongs_to :user
end
