class AssessmentRange < ActiveRecord::Base
  include ActiveInactiveStateTransitions

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  attr_readonly :code

  validates :code,        presence: true,
                          length:     { in: 1..255 },
                          uniqueness: { case_sensitive: false }
  validates :start_date,  presence: true,
                          timeliness: { type: :date }
  validates :end_date,    presence: true,
                          timeliness: { after: :start_at, type: :date}

  scope :active, -> { where(state: 'active') }
end
