class PercentageAssessmentsController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @object = PercentageAssessment.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def new
    @object = PercentageAssessment.new
    set_breadcrum_for_new
  end

  def create
    @object = PercentageAssessment.new(percentage_assessment_params)
    set_breadcrum_for_new

    @object.save ? redirect_to(@object) : render('new')
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)

    @object.attributes = percentage_assessment_params
    @object.save ? redirect_to(@object) : render('new')
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    @object.destroy ? redirect_to(@object) : redirect_to(faculties_path)
  end

private

  def find_by_and_decorate(id)
    decorate PercentageAssessment.find(id)
  end

  def percentage_assessment_params
    params.require(:percentage_assessment)
          .permit(
            :name,
            :description,
            :value
          )
  end

  def set_page_title
    @page_title ||= 'Bobot Penilaian'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, percentage_assessments_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.name, percentage_assessment_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_percentage_assessment_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_percentage_assessment_url(object)
  end
end