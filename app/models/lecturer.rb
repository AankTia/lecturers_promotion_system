class Lecturer < ActiveRecord::Base
  include ActiveInactiveStateTransitions

  belongs_to :study_program
  belongs_to :rank_of_lecturer

  validates :registration_number_of_employees,  presence: true,
                                                length:     { in: 1..255 },
                                                uniqueness: { case_sensitive: true }
  validates :study_program_id,    presence: true
  validates :rank_of_lecturer_id, presence: true
  validates :name,                presence: true
  validates :place_of_birth,      presence: true
  validates :date_of_birth,       presence: true,
                                  timeliness: { type: :date}
  validates :gender,              presence: true
  validates :position,            presence: true
  validates :education,           presence: true
  validates :date_of_addmission,  presence: true,
                                  timeliness: { type: :date}
  validates :marital_status,      presence: true
end
