class ActiveInacticeStateTransitionDecorator < ApplicationDecorator

  def active_inactive_state_action
    [
      link_to_new,
      (object.inactive? ? link_to_edit : ''),
      (object.inactive? ? link_to_destroy : ''),
      link_to_activate,
      link_to_deactivate
    ].join(" ").html_safe
  end

  def link_to_activate
    h.link_to "Activate", activate_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_activate?
  end

  def link_to_deactivate
    h.link_to "Deactivate", deactivate_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_deactivate?
  end

  def state_with_color
    h.content_tag(:span, state.humanize, class: state_klass)
  end

  def state_klass
    if inactive?
      "label label-default"
    elsif active?
      "label label-primary"
    else
      ''
    end
  end

end