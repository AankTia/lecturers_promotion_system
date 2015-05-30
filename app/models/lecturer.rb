class Lecturer < ActiveRecord::Base
  include ActiveInactiveStateTransitions
  extend Enumerize

  MALE = 'male'
  FEMALE = 'female'

  LAJANG = 'lajang'
  MENIKAH = 'menikah'
  BERCERAI = 'bercerai'

  SMA = 'sma'
  DIPLOMA = 'diploma'
  SARJANA = 'sarjana'
  MAGISTER = 'magister'
  DOCTOR = 'doctor'

  enumerize :gender, in: [MALE, FEMALE]
  enumerize :marital_status, in: [LAJANG, MENIKAH, BERCERAI]
  enumerize :education, in: [SMA, DIPLOMA, SARJANA, MAGISTER, DOCTOR]

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

  scope :active, -> { where(state: 'active') }
end
