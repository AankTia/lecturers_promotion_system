class AssessmentResult::Action::Update < ResourceAction::Base
  attr_accessor :assessment_result, :params

  def process_run
    ActiveRecord::Base.transaction do
      retain_attribute
      if assessment_result.valid?
        assessment_result.save!
        assessment_result
      else
        raise_invalid_action!(full_messages_from(assessment_result))
      end
    end
  end

  def retain_attribute
    assessment_result.update(
      lecturer_id: params[:lecturer_id],
      assessor_id: params[:assessor_id]
    )
    params[:assessment_result_lines_attributes].each do |key, values|
      line = assessment_result.assessment_result_lines.find_by(percentage_assessment_id: values[:percentage_assessment_id].to_i)
      line.update(value: BigDecimal.new(values[:value]))
    end

    assessment_result_calculator = AssessmentResultCalculator.new(assessment_result: assessment_result)
    assessment_result.update(weighting_value: assessment_result_calculator.weighting_value)
    assessment_result.update(average_value: assessment_result_calculator.average_value)
  end

end