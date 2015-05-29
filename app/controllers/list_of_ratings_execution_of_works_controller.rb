class ListOfRatingsExecutionOfWorksController < ApplicationController
  include DefaultStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = ListOfRatingsExecutionOfWork.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    @object = ListOfRatingsExecutionOfWork.new
    set_breadcrum_for_new
  end

  def create
    @object = ListOfRatingsExecutionOfWork.new(list_of_ratings_execution_of_work_params)
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
    update_callback_for @object
    set_breadcrumb_for_edit @object
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    destroy_callback_for @object
  end

  def export_pdf
    @object = find_by_and_decorate(params[:id])
    if @object.completed?
      pdf = Pdf::ListOfRatingsExecutionOfWorkPdf.new(object: @object)
      send_data pdf.render, filename: "DP3 (#{@object.code})",
                            type: "application/pdf",
                            disposition: "inline"
    else
      redirect_to @object, flash: {alert: "Tidak bisa membuat dokumen, DP3 harus Complete trlebih dahulu"}
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
    decorate ListOfRatingsExecutionOfWork.find(id)
  end

  def list_of_ratings_execution_of_work_params
    params.require(:list_of_ratings_execution_of_work)
          .permit(
            :assessor_id,
            :assessment_result_id,
            :objection,
            :objection_date,
            :response,
            :response_date,
            :decision,
            :decision_date
          )
  end

  def set_page_title
    @page_title ||= 'Daftar Penilaian Pelaksanaan Pekerjaan (DP3)'
  end

  def set_breadcrumb_for_index
    add_breadcrumb 'DP3', list_of_ratings_execution_of_works_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.code, list_of_ratings_execution_of_work_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_list_of_ratings_execution_of_work_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_list_of_ratings_execution_of_work_url(object)
  end
end