module ErrorHelper

  def error_class(object, attribute)
    'parsley-error' if object.errors.include?(attribute)
  end

  def error_messages(object, attribute)
    if object.errors.include?(attribute) #.present?
      content_tag(:ul, content_tag(:li, object.errors.get(attribute).to_sentence, class: 'parsley-required'), class: 'parsley-errors-list filled')
    end
  end

end