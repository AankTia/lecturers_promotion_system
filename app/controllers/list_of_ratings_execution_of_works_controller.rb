class ListOfRatingsExecutionOfWorksController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = ListOfRatingsExecutionOfWork.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
    set_breadcrumb_for_index
  end

  def new
    @object = ListOfRatingsExecutionOfWork.new
    set_breadcrum_for_new
  end

  def create
    @object = ListOfRatingsExecutionOfWork.new(list_of_ratings_execution_of_work_params)
    set_breadcrum_for_new
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    set_breadcrumb_for_edit(@object)
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui DP3."} unless @object.draft?
  end

  def update
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    set_breadcrumb_for_edit(@object)
    if @object.draft? && @object.update(list_of_ratings_execution_of_work_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    if @object.draft? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def export_pdf
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
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
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
    if @object.can_confirm?
      @object.confirm!
      redirect_to @object, flash: {notice: "Confirm DP3 Success"}
    else
      redirect_to @object, flash: {alert: "DP3 tidak bisa di Confirm"}
    end
  end

  def revise
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
    if @object.can_revise?
      @object.revise!
      redirect_to @object, flash: {notice: "Revise DP3 Success"}
    else
      redirect_to @object, flash: {alert: "DP3 tidak bisa di Revise"}
    end
  end

  def cancel
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
    if @object.can_cancel?
      @object.cancel!
      redirect_to @object, flash: {notice: "DP3 berhasil di di batalkan"}
    else
      redirect_to @object, flash: {alert: "DP3 tidak bisa di batalkan"}
    end
  end

  def complete
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
    if @object.can_complete?
      @object.complete!
      redirect_to @object, flash: {notice: "DP3 Complete"}
    else
      redirect_to @object, flash: {alert: "DP3 tidak bisa Complete"}
    end
  end

private

  def list_of_ratings_execution_of_work_params
    params.require(:list_of_ratings_execution_of_work)
          .permit(:assessor_id,
                  :assessment_result_id,
                  :objection,
                  :objection_date,
                  :response,
                  :response_date,
                  :decision,
                  :decision_date)
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