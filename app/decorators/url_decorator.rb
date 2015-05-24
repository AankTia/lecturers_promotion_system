module UrlDecorator


  def object_name_singularize
    object.class.model_name.name.tableize.singularize
  end

  def show_object_url
    h.send("#{object_name_singularize}_url",object)
  end

  def new_object_url
    h.send("new_#{object_name_singularize}_url")
  end

  def edit_object_url
    h.send("edit_#{object_name_singularize}_url",object)
  end

  def destroy_object_url
    url = h.send("#{object_name_singularize}_url",object)
  end

  def confirm_object_url
    h.send("confirm_#{object_name_singularize}_url",object)
  end

  def revise_object_url
    h.send("revise_#{object_name_singularize}_url",object)
  end

  def cancel_object_url
    h.send("cancel_#{object_name_singularize}_url",object)
  end

  def complete_object_url
    h.send("complete_#{object_name_singularize}_url",object)
  end

  def activate_object_url
    h.send("activate_#{object_name_singularize}_url",object)
  end

  def deactivate_object_url
    h.send("deactivate_#{object_name_singularize}_url",object)
  end


end