class ListOfRatingsExecutionOfWork < ActiveRecord::Base
  include DefaultStateTransitions

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  belongs_to :assessment_result
  belongs_to :assessor

  validates :assessor_id,           presence: true,
                                    inclusion: { in: proc { Assessor.active.pluck(:id) }}
  validates :assessment_result_id,  presence: true,
                                    inclusion: { in: proc { AssessmentResult.completed.pluck(:id) }}
  validate  :uniq_assessor

  scope :completed, -> { where(state: 'completed') }

  def uniq_assessor
    if assessor_id == assessment_result.assessor_id
      errors.messages[:assessor_id] = ["Atasan Penilai sama dengan Penilai dalam Penilaian"]
    end
  end
end
