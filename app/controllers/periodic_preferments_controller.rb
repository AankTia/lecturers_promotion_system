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
  end

  def update
    @object = PeriodicPreferment.find(params[:id])
    if @object.update(periodic_preferment_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = PeriodicPreferment.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def export_pdf
    @object = PeriodicPreferment.find(params[:id])
    pdf = Pdf::PeriodicPrefermentPdf.new(object: @object)
    send_data pdf.render, filename: "Surat Kenaikan Pangkat Berkala",
                          type: "application/pdf",
                          disposition: "inline"
  end

private

  def periodic_preferment_params
    params.require(:periodic_preferment)
          .permit(:preferment_id,
                  :periodic_preferment_date,
                  :periodic_preferment_number)
  end
end