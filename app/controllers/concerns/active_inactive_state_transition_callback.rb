module ActiveInactiveStateTransitionCallback

  def edit_callback_for(object)
    redirect_to object, flash: {error: "Tidak bisa memperbaharui dalam status #{object.state}"} unless object.inactive?
  end

  def update_callback_for(object, params)
    if object.inactive?
      object.attributes = params
      object.save ? redirect_to(object) : render('edit')
    else
      redirect_to object, flash: {error: "Tidak bisa memperbaharui dalam status #{object.state}"}
    end
  end

  def destroy_callback_for(object)
    if object.inactive? && object.destroy
      url = send("#{object.object.class.to_s.tableize}_url")
      redirect_to url
    else
      redirect_to object, flash: {error: "Gagal menghapus"}
    end
  end

  def activate_callback_for(object)
    if object.can_activate?
      object.activate!
      redirect_to object, flash: {success: "Aktivasi Success"}
    else
      redirect_to object, flash: {error: "Aktivasi Gagal"}
    end
  end

  def deactivate_callback_for(object)
    if object.can_deactivate?
      object.deactivate!
      redirect_to object, flash: {success: "Deaktivasi Success"}
    else
      redirect_to object, flash: {error: "Deactivasi Gagal"}
    end
  end

end