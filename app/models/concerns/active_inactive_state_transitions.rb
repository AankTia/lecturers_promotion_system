module ActiveInactiveStateTransitions
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Transitions

    state_machine do
      state :inactive
      state :active

      event :activate do
        transitions to: :active, from: :inactive
      end

      event :deactivate do
        transitions to: :inactive, from: :active
      end
    end
  end
end