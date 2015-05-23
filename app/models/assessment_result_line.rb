class AssessmentResultLine < ActiveRecord::Base

  belongs_to :assessment_result, inverse_of: :assessment_result_lines
  belongs_to :percentage_assessment

end
