module DefaultStateTransitions
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Transitions

    state_machine do
      state :draft
      state :confirmed
      state :completed
      state :cancelled
      state :closed

      event :confirm do
        transitions to: :confirmed, from: :draft
      end
      event :revise do
        transitions to: :draft, from: :confirmed
      end
      event :cancel do
        transitions to: :cancelled, from: :confirmed
      end
      event :complete do
        transitions to: :completed, from: [:confirmed, :draft]
      end
      event :close do
        transitions to: :closed, from: :completed
      end
    end
  end
end