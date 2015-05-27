module ErrorHelper

  def error_class(object, attribute)
    'has-error' if object.errors.include?(attribute)
  end

  def error_messages(object, attribute)
    if object.errors.include?(attribute).present?
      content_tag(:i, object.errors.get(attribute).to_sentence, class: 'help-block', for: attribute.to_s)
      # content_tag(:span, object.errors.get(attribute).to_sentence, :class => 'help-block', :for => attribute.to_s)
    end
  end

end