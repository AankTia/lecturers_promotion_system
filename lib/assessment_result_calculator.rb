class AssessmentResultCalculator
  attr_reader :assessment_result

  def initialize(assessment_result:)
    @assessment_result = assessment_result
  end

  def assessment_value
    result = 0
    assessment_result.assessment_result_lines.each do |line|
      percentage_assessment_value = percentage_assessment_value_by(line.percentage_assessment_id)
      result += line.value.to_f ** (percentage_assessment_value.to_f/100)
    end
    result
  end

private

  def percentage_assessment_value_by(id)
    PercentageAssessment.find(id).value
  end

end