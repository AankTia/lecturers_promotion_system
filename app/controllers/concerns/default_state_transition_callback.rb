module DefaultStateTransitionCallback

  def edit_callback_for(object)
    redirect_to object, flash: {error: "Tidak bisa memperbaharui dalam status #{object.state}"} unless object.draft?
  end

  def update_callback_for(object, params)
    if object.draft?
      object.attributes = params
      object.save ? redirect_to(@object) : render('new')
    else
      redirect_to object, flash: {error: "Tidak bisa memperbaharui dalam status #{object.state}"}
    end
  end

  def destroy_callback_for(object)
    if @object.draft? && @object.destroy
      url = send("#{object.object.class.to_s.tableize}_url")
      redirect_to url
    else
      redirect_to object, flash: {error: "Gagal menghapus"}
    end
  end

  def confirm_callback_for(object)
    if object.can_confirm?
      object.confirm!
      redirect_to object, flash: {success: "Confirm Success"}
    else
      redirect_to object, flash: {error: "Confirm Gagal"}
    end
  end

  def revise_callback_for(object)
    if object.can_revise?
      object.revise!
      redirect_to @object, flash: {success: "Revise Success"}
    else
      redirect_to @object, flash: {error: "Revise Gagal"}
    end
  end

  def cancel_callback_for(object)
    if object.can_cancel?
      object.cancel!
      redirect_to object, flash: {success: "Cancel Success"}
    else
      redirect_to object, flash: {error: "Cancel Gagal"}
    end
  end

  def complete_callback_for(object)
    if object.can_complete?
      object.complete!
      redirect_to object, flash: {success: "Complete Success"}
    else
      redirect_to object, flash: {error: "Complete Gagal"}
    end
  end

end