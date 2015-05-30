class StudyProgram < ActiveRecord::Base
  extend Enumerize

  DIPLOMA = 'diploma'
  SARJANA = 'sarjana'
  MAGISTER = 'magister'
  DOCTOR = 'doctor'

  attr_readonly :code

  belongs_to :faculty

  enumerize :education_level, in: [DIPLOMA, SARJANA, MAGISTER, DOCTOR]

  validates :code,            presence: true,
                              length:     { in: 1..255 },
                              uniqueness: { case_sensitive: false }
  validates :name,            presence: true
  validates :education_level, presence: true
  validates :faculty_id,      presence: true,
                              inclusion: { in: proc { Faculty.pluck(:id) }}
end
