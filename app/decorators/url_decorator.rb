module UrlDecorator

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

  def object_name_singularize
    object.class.model_name.name.tableize.singularize
  end

end