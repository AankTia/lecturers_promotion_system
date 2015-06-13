class DefaultStateTransitionDecorator < ApplicationDecorator

  def default_state_action
    [
      link_to_new,
      (object.draft? ? link_to_edit : ''),
      (object.draft? ? link_to_destroy : ''),
      link_to_confirm,
      link_to_revise,
      link_to_cancel,
      link_to_complete
    ].join(" ").html_safe
  end

  def link_to_confirm
    h.link_to "Confirm", confirm_object_url, method: :post, class: "btn btn-info btn-sm" if object.can_confirm?
  end

  def link_to_revise
    h.link_to "Revise", revise_object_url, method: :post, class: "btn btn-warning btn-sm" if object.can_revise?
  end

  def link_to_cancel
    h.link_to "Cancel", cancel_object_url, method: :post, class: "btn btn-danger btn-sm" if object.can_cancel?
  end

  def link_to_complete
    h.link_to "Complete", complete_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_cancel?
  end

  def state_with_color
    h.content_tag(:span, state.humanize, class: state_klass)
  end

  def state_klass
    if draft?
      "label label-default"
    elsif confirmed?
      "label label-info"
    elsif cancelled?
      "label label-danger"
    elsif completed?
      "label label-success"
    else
      ''
    end
  end

end