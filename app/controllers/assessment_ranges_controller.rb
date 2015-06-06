class AssessmentRangesController < ApplicationController
  include ActiveInactiveStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = AssessmentRange.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    @object = AssessmentRange.new
    set_breadcrum_for_new
  end

  def create
    @object = AssessmentRange.new(assessment_range_params)
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
    update_callback_for @object, assessment_range_params
    set_breadcrumb_for_edit @object
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    destroy_callback_for @object
  end

  def activate
    @object = find_by_and_decorate(params[:id])
    activate_callback_for @object
  end

  def deactivate
    @object = find_by_and_decorate(params[:id])
    deactivate_callback_for @object
  end

private

  def find_by_and_decorate(id)
    decorate AssessmentRange.find(id)
  end

  def assessment_range_params
    params.require(:assessment_range)
          .permit(
            :code,
            :start_date,
            :end_date,
            :description
          )
  end

  def set_page_title
    @page_title ||= 'Waktu Penilaian'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, assessment_ranges_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.code, assessment_range_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_assessment_range_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_assessment_range_url(object)
  end
end