class Faculty < ActiveRecord::Base
  attr_readonly :code
  
  # has_many :study_programs, inverse_of: :study_program, dependent: :destroy
  
  validates :code, presence: true,
                   length:     { in: 1..255 },
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
