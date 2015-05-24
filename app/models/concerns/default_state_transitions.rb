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

    # searchable do
    #   integer :id
    #   string :state
    #   time :created_at
    #   time :updated_at
    # end
  end

  # module ClassMethods
  #   def all_states
  #     [:draft,:confirmed,:completed,:cancelled,:closed]
  #   end

  #   # def state_datatable_column_options
  #   #   result = []
  #   #   result << {
  #   #     column: :state,
  #   #     select2: self.all_states.map { |obj| [obj,obj] },
  #   #     formatter: proc { |obj| obj.state_with_colour }
  #   #   }
  #   #   result << {
  #   #     column: :created_at,
  #   #     datetime: true,
  #   #     display: I18n.t('created_at')
  #   #   }
  #   #   result << {
  #   #     column: :updated_at,
  #   #     datetime: true,
  #   #     display: I18n.t('updated_at')
  #   #   }
  #   #   result
  #   # end
  # end
end