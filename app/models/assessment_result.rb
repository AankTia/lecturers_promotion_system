class AssessmentResult < ActiveRecord::Base
  include DefaultStateTransitions

  attr_readonly :code

  belongs_to :lecturer
  belongs_to :assessor

  has_many :assessment_result_lines, inverse_of: :assessment_result, dependent: :destroy

  accepts_nested_attributes_for :assessment_result_lines, reject_if: :all_blank, allow_destroy: true

  validates :code,                    presence: true,
                                      uniqueness: { case_sensitive: false }
  validates :lecturer_id,             presence: true,
                                      inclusion: { in: proc { Lecturer.active.pluck(:id) }}
  validates :assessor_id,             presence: true,
                                      inclusion: { in: proc { Assessor.active.pluck(:id) }}
  validates :start_date,              presence: true,
                                      timeliness: { type: :date }
  validates :end_date,                presence: true,
                                      timeliness: { after: :start_at, type: :date}
  validates :assessment_result_lines, presence: true

  scope :completed, -> { where(state: 'completed') }
end
