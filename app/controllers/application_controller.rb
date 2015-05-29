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

  def generate_index_data_for(object)
    @index_data = []
    decorated_objects = decorate object
    decorated_objects.each {|o| @index_data << o.index_data}
  end

end
