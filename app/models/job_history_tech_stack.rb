class JobHistoryTechStack < ApplicationRecord
  belongs_to :job_history
  belongs_to :tech_stack

  validates :tech_stack_id, uniqueness: { scope: :job_history_id }
end
