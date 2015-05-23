class DocumentAction::AssessmentResult::Save < DocumentAction::Base
  attr_accessor :assessment_result

  def process_run
    ActiveRecord::Base.transaction do
      retain_attribute
      assessment_result.save
    end
  end

private

  def retain_attribute
    assessment_result_value = AssessmentResultCalculator.new(assessment_result: assessment_result).assessment_value

    assessment_result.code = generate_code if assessment_result.new_record?
    assessment_result.value = assessment_result_value
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