class ListOfRatingsExecutionOfWork < ActiveRecord::Base

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  belongs_to :assessment_result
  belongs_to :assessor

  validates :assessor_id, presence: true
  validates :assessment_result_id, presence: true

end
