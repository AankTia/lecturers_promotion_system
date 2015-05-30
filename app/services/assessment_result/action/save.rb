class AssessmentResult::Action::Save < ResourceAction::Base
  attr_accessor :assessment_result

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

private

  def retain_attribute
    assessment_result_calculator = AssessmentResultCalculator.new(assessment_result: assessment_result)

    assessment_result.code = generate_code if assessment_result.new_record? & !assessment_result.code.present?
    assessment_result.weighting_value = assessment_result_calculator.weighting_value
    assessment_result.average_value = assessment_result_calculator.average_value
  end

  def generate_code
    if assessment_result.lecturer.present? &&
       assessment_result.assessor.present? &&
       assessment_result.start_date.present? &&
       assessment_result.end_date.present?
       lecturer_registration_number = assessment_result.lecturer.registration_number_of_employees
       assessor_registration_number = assessment_result.assessor.registration_number_of_employees
      "assessment_#{lecturer_registration_number}_#{assessor_registration_number}_#{assessment_result.start_date}_#{assessment_result.end_date}"
    else
      nil
    end
  end

end