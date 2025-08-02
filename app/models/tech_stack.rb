class TechStack < ApplicationRecord
  extend FriendlyId

  friendly_id :slug, use: :slugged

  validates :slug, uniqueness: true
end
