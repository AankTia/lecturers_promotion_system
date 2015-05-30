class Preferment::Action::Save < ResourceAction::Base
  attr_accessor :preferment

  def process_run
    ActiveRecord::Base.transaction do
      retain_attribute
      if preferment.valid?
        preferment.save!
        preferment
      else
        raise_invalid_action!(full_messages_from(preferment))
      end
    end
  end

  def retain_attribute
    preferment.current_rank_of_lecturer_id = current_rank_of_lecturer
  end

private

  def current_rank_of_lecturer
    list_of_ratings_execution_of_work = preferment.try(:list_of_ratings_execution_of_work)
    assessment_result = list_of_ratings_execution_of_work.try(:assessment_result)
    assessment_result.try(:lecturer_id)
  end
end