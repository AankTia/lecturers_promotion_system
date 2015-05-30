class ResourceAction::Base
  include ActiveModel::Model

  attr_reader :result

  def run
    run!
    true
    rescue ResourceAction::Invalid => e
      self.errors.add(:base,e.message)
      false
  end

  def run!
    if valid?
      @result = process_run
    else
      raise_invalid_action!(full_messages_from(self))
    end
    result
  end

  def raise_invalid_action!(message,options={})
    if message.is_a? Symbol
      message = translated_error_message(message,options)
    end
    raise ResourceAction::Invalid, message
  end

  def process_run
    raise NotImplementedError
  end

  def full_error_message
    full_messages_from(self)
  end

  def full_messages_from(active_model)
    active_model.errors.full_messages.join(", ")
  end

end