class JobHistory < ApplicationRecord
  has_one_attached :cover
  has_rich_text :description

  belongs_to :user
end
