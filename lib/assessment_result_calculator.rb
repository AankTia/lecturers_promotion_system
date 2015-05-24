class AssessmentResultCalculator
  attr_reader :assessment_result

  def initialize(assessment_result:)
    @assessment_result = assessment_result
  end

  def weighting_value
    result = 0
    assessment_result.assessment_result_lines.each do |line|
      percentage_assessment_value = percentage_assessment_value_by(line.percentage_assessment_id)
      result += line.value.to_f ** (percentage_assessment_value.to_f/100)
    end
    result
  end

  def average_value
    assessment_result_lines = assessment_result.assessment_result_lines
    assessment_result_lines.map(&:value).sum / assessment_result_lines.size
  end

private

  def percentage_assessment_value_by(id)
    PercentageAssessment.find(id).value
  end

end