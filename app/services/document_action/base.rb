class DocumentAction::Base
  include ActiveModel::Model

  def run
    if valid?
      process_run
    else
      # raise_invalid_action!(full_messages_from(self))
      raise 'a'
    end
  end

  def run!
    raise 'a'
  end

  def process_run
    raise NotImplementedError
  end

  def raise_invalid_action!(message,options={})
    if message.is_a? Symbol
      message = translated_error_message(message,options)
    end
    raise DocumentAction::ActionInvalid, message
  end

  def full_messages_from(active_model)
    active_model.errors.full_messages.join(", ")
  end

end