class JobHistoryTechStack < ApplicationRecord
  belongs_to :job_history
  belongs_to :tech_stack

  validates :job_history, uniqueness: true
end
