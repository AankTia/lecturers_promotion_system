class AssessmentResult::Action::New
  attr_reader :assessment_result

  def initialize
    @assessment_result = AssessmentResult.new
    PercentageAssessment.all.each do |percentage_assessment|
      assessment_result.assessment_result_lines.build(
        percentage_assessment_id: percentage_assessment.id,
        value: 0
      )
    end
    @assessment_result
  end

end