module ApplicationHelper
  include ErrorHelper

  def set_sidebar(title:, url:, controller: nil)
    klass = if (controller.present? && (params[:controller] == controller)) ||
               (url.gsub('/','') == params[:controller])
              'active'
            else
              ''
            end

    content_tag(:li, class: klass) do
      link_to title, url
    end
  end
end
