class PercentageAssessment < ActiveRecord::Base
  attr_readonly :code
  
  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  validates :code,  presence: true,
                    length:     { in: 1..255 },
                    uniqueness: { case_sensitive: false }
  validates :name,  presence: true
  validates :value, presence: true,
                    numericality: { greater_than: 0 }
end
