class PeriodicPreferment < ActiveRecord::Base
  include DefaultStateTransitions

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  belongs_to :preferment

  validates :code,                        presence: true
  validates :preferment_id,               presence: true
  validates :periodic_preferment_number,  presence: true
  validates :periodic_preferment_date,    presence: true,
                                          timeliness: { type: :date }

end
