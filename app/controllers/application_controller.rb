class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_breadcrumb

  def set_breadcrumb
    add_breadcrumb "Home", :root_path
  end

  def decorate(object)
    object.decorate
  end

end
