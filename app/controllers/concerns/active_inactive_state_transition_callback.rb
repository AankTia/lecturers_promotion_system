module ActiveInactiveStateTransitionCallback

  def edit_callback_for(object)
    redirect_to object, flash: {alert: "Tidak bisa memperbaharui dalam status #{object.state}"} unless object.inactive?
  end

  def update_callback_for(object)
    if object.inactive?
      object.attributes = assessor_params
      object.save ? redirect_to(object) : render('edit')
    else
      redirect_to object, flash: {alert: "Tidak bisa memperbaharui dalam status #{object.state}"}
    end
  end

  def destroy_callback_for(object)
    if object.draft? && object.destroy
      url = send("#{object.object.class.to_s.tableize}_url")
      redirect_to url
    else
      redirect_to object, flash: {alert: "Gagal menghapus"}
    end
  end

  def activate_callback_for(object)
    if object.can_activate?
      object.activate!
      redirect_to object, flash: {notice: "Aktivasi Success"}
    else
      redirect_to object, flash: {alert: "Aktivasi Gagal"}
    end
  end

  def deactivate_callback_for(object)
    if object.can_deactivate?
      object.deactivate!
      redirect_to object, flash: {notice: "Deaktivasi Success"}
    else
      redirect_to object, flash: {alert: "Deactivasi Gagal"}
    end
  end

end