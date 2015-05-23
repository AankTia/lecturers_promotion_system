class ListOfRatingsExecutionOfWorksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = ListOfRatingsExecutionOfWork.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
  end

  def new
    @object = ListOfRatingsExecutionOfWork.new
  end

  def create
    @object = ListOfRatingsExecutionOfWork.new(list_of_ratings_execution_of_work_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = ListOfRatingsExecutionOfWork.find(params[:id]).decorate
  end

  def edit
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
  end

  def update
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    if @object.update(list_of_ratings_execution_of_work_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def export_pdf
    @object = ListOfRatingsExecutionOfWork.find(params[:id])
    pdf = Pdf::ListOfRatingsExecutionOfWorkPdf.new(object: @object)
    send_data pdf.render, filename: "DP3 (#{@object.code})",
                          type: "application/pdf",
                          disposition: "inline"
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
end