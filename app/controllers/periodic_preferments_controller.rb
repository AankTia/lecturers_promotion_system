class PeriodicPrefermentsController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = PeriodicPreferment.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
    set_breadcrumb_for_index
  end

  def new
    @object = PeriodicPreferment.new
    set_breadcrum_for_new
  end

  def create
    @object = PeriodicPreferment.new(periodic_preferment_params)
    set_breadcrum_for_new
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = PeriodicPreferment.find(params[:id]).decorate
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = PeriodicPreferment.find(params[:id])
    set_breadcrumb_for_edit(@object)
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Kenaikan Pangkat Berkala"} unless @object.draft?
  end

  def update
    @object = PeriodicPreferment.find(params[:id])
    set_breadcrumb_for_edit(@object)
    if @object.draft? && @object.update(periodic_preferment_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = PeriodicPreferment.find(params[:id])
    if @object.draft? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def export_pdf
    @object = PeriodicPreferment.find(params[:id])
    if @object.completed?
      pdf = Pdf::PeriodicPrefermentPdf.new(object: @object)
      send_data pdf.render, filename: "Surat Kenaikan Pangkat Berkala",
                            type: "application/pdf",
                            disposition: "inline"
    else
      redirect_to @object, flash: {alert: "Tidak bisa membuat PDF, Kenaikan Pangkat Berkala harus Complete trlebih dahulu"}
    end
  end

  def confirm
    @object = PeriodicPreferment.find(params[:id]).decorate
    if @object.can_confirm?
      @object.confirm!
      redirect_to @object, flash: {notice: "Confirm Kenaikan Pangkat Berkala Success"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat Berkala tidak bisa di Confirm"}
    end
  end

  def revise
    @object = PeriodicPreferment.find(params[:id]).decorate
    if @object.can_revise?
      @object.revise!
      redirect_to @object, flash: {notice: "Revise Kenaikan Pangkat Berkala Success"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat Berkala tidak bisa di Revise"}
    end
  end

  def cancel
    @object = PeriodicPreferment.find(params[:id]).decorate
    if @object.can_cancel?
      @object.cancel!
      redirect_to @object, flash: {notice: "Kenaikan Pangkat Berkala berhasil di di batalkan"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat Berkala tidak bisa di batalkan"}
    end
  end

  def complete
    @object = PeriodicPreferment.find(params[:id]).decorate
    if @object.can_complete?
      @object.complete!
      redirect_to @object, flash: {notice: "Kenaikan Pangkat Berkala Complete"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat Berkala tidak bisa Complete"}
    end
  end

private

  def periodic_preferment_params
    params.require(:periodic_preferment)
          .permit(:preferment_id,
                  :periodic_preferment_date,
                  :periodic_preferment_number)
  end

  def set_page_title
    @page_title ||= 'Kenaikan Pangkat Berkala'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, periodic_preferments_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.periodic_preferment_number, periodic_preferment_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_periodic_preferment_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_periodic_preferment_url(object)
  end
end