class AssessmentResult::Action::CreateListOfRatingsExecutionOfWork < ResourceAction::Base
  attr_accessor :assessment_result
  attr_reader :list_of_ratings_execution_of_work

  def process_run
    assessor = Assessor.active.pluck(:id)- [assessment_result.assessor_id]
    @list_of_ratings_execution_of_work = ListOfRatingsExecutionOfWork.new(
      assessor_id: assessor.sample,
      assessment_result_id: assessment_result.id
    )

    if list_of_ratings_execution_of_work.valid?
      list_of_ratings_execution_of_work.save!
      list_of_ratings_execution_of_work
    else
      raise_invalid_action!(full_messages_from(list_of_ratings_execution_of_work))
    end
  end

end