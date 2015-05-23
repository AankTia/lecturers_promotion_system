class StudyProgram < ActiveRecord::Base
  attr_readonly :code

  belongs_to :faculty
  
  validates :code, presence: true,
                   length:     { in: 1..255 },
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :faculty_id, presence: true
end
