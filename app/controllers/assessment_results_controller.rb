class AssessmentResultsController < ApplicationController
  include DefaultStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = AssessmentResult.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    action = AssessmentResult::Action::New.new
    @object = decorate action.assessment_result
    set_breadcrum_for_new
  end

  def create
    @object = AssessmentResult.new(assessment_result_params)
    set_breadcrum_for_new

    action = AssessmentResult::Action::Save.new(assessment_result: @object)
    action.run ? redirect_to(@object) : render('new')
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    edit_callback_for @object
    set_breadcrumb_for_edit(@object)
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)

    action = AssessmentResult::Action::Update.new(assessment_result: @object, params: assessment_result_params)
    action.run ? redirect_to(@object) : render('edit')
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    destroy_callback_for @object
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

  def create_list_of_ratings_execution_of_work
    @object = find_by_and_decorate(params[:id])
    action = AssessmentResult::Action::CreateListOfRatingsExecutionOfWork.new(assessment_result: @object)
    if action.run
      redirect_to action.list_of_ratings_execution_of_work
    else
      redirect_to object, flash: {alert: "Tidak bisa membuat DP3"}
    end
  end

private

  def find_by_and_decorate(id)
    decorate AssessmentResult.find(id)
  end

  def assessment_result_params
    params.require(:assessment_result)
          .permit(
            :lecturer_id,
            :assessor_id,
            :start_date,
            :end_date,
            assessment_result_lines_attributes: [
              :percentage_assessment_id,
              :value,
              :_destroy
            ]
          )
  end

  def set_page_title
    @page_title ||= 'Penilaian'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, assessment_results_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.code, assessment_results_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_assessment_result_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", assessment_results_url(object)
  end
end