class JobHistory < ApplicationRecord
  has_one_attached :cover
  has_rich_text :description

  has_many :job_history_tech_stacks, dependent: :destroy
  has_many :stacks, through: :job_history_tech_stacks
  accepts_nested_attributes_for :stacks

  belongs_to :user
end
