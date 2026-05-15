class JobHistory < ApplicationRecord
  has_one_attached :cover
  has_rich_text :description

  has_many :job_history_tech_stacks, dependent: :destroy
  has_many :stacks, through: :job_history_tech_stacks
  accepts_nested_attributes_for :stacks

  belongs_to :user

  validates :company_name, :job_title, :start_date, presence: true
  validates :website_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  validate :end_date_not_before_start_date
  validate :end_date_absent_when_current

  broadcasts_to ->(_j) { "job_histories" },
                target: "job_history_list",
                inserts_by: :append,
                partial: "dashboard/job_histories/job_history"

  private

  def end_date_not_before_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be on or after start date") if end_date < start_date
  end

  def end_date_absent_when_current
    return unless is_current && end_date.present?

    errors.add(:end_date, "must be blank when this is your current job")
  end
end
