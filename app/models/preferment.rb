class Preferment < ActiveRecord::Base
  include DefaultStateTransitions

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  belongs_to :list_of_ratings_execution_of_work
  belongs_to :rank_of_lecturer
  belongs_to :current_rank_of_lecturer, class_name: "RankOfLecturer"

  validates :list_of_ratings_execution_of_work_id, presence: true,
                                                   inclusion: { in: proc { ListOfRatingsExecutionOfWork.completed.pluck(:id) }}
  validates :rank_of_lecturer_id,                  presence: true
  validates :current_rank_of_lecturer_id,          presence: true
  validates :decision_letter_number,               presence: true
  validates :submissions_preferment_date,          presence: true,
                                                   timeliness: { type: :date }
  validates :preferment_date,                      presence: true,
                                                   timeliness: { after: :submissions_preferment_date, type: :date}

  scope :completed, -> { where(state: 'completed') }
end
