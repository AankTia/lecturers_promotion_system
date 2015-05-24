class PeriodicPreferment < ActiveRecord::Base
  include DefaultStateTransitions

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  belongs_to :preferment

end
