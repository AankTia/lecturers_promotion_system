class PeriodicPrefermentsController < ApplicationController
  include DefaultStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = PeriodicPreferment.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    @object = PeriodicPreferment.new
    set_breadcrum_for_new
  end

  def create
    @object = PeriodicPreferment.new(periodic_preferment_params)
    set_breadcrum_for_new

    @object.save ? redirect_to(@object) : render('new')
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    edit_callback_for @object
    set_breadcrumb_for_edit @object
  end

  def update
    @object = find_by_and_decorate(params[:id])
    update_callback_for @object, periodic_preferment_params
    set_breadcrumb_for_edit @object
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    destroy_callback_for @object
  end

  def export_pdf
    @object = find_by_and_decorate(params[:id])
    if @object.completed?
      pdf = PeriodicPreferment::Pdf.new(object: @object)
      send_data pdf.render, filename: "Surat Kenaikan Pangkat Berkala",
                            type: "application/pdf",
                            disposition: "inline"
    else
      redirect_to @object, flash: {alert: "Tidak bisa membuat PDF, Kenaikan Pangkat Berkala harus Complete trlebih dahulu"}
    end
  end

  def confirm
    @object = find_by_and_decorate(params[:id])
    confirm_callback_for @object
  end

  def revise
    @object = find_by_and_decorate(params[:id])
    revise_callback_for @object
  end

  def cancel
    @object = find_by_and_decorate(params[:id])
    cancel_callback_for @object
  end

  def complete
    @object = find_by_and_decorate(params[:id])
    complete_callback_for @object
  end

private

  def find_by_and_decorate(id)
    decorate PeriodicPreferment.find(id)
  end

  def periodic_preferment_params
    params.require(:periodic_preferment)
          .permit(
            :preferment_id,
            :periodic_preferment_date,
            :periodic_preferment_number
          )
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