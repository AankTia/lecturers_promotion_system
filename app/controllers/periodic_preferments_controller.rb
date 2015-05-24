class PeriodicPrefermentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = PeriodicPreferment.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
  end

  def new
    @object = PeriodicPreferment.new
  end

  def create
    @object = PeriodicPreferment.new(periodic_preferment_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = PeriodicPreferment.find(params[:id]).decorate
  end

  def edit
    @object = PeriodicPreferment.find(params[:id])
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Kenaikan Pangkat Berkala"} unless @object.draft?
  end

  def update
    @object = PeriodicPreferment.find(params[:id])
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
      redirect_to @object, flash: {alert: "Tidak bisa membuat PDF, Kenaikan Pngkat Berkala harus Complete trlebih dahulu"}
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
end