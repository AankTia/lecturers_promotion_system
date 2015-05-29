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
    assessment_result = AssessmentResult.new
    PercentageAssessment.all.each do |percentage_assessment|
      assessment_result.assessment_result_lines.build(
        percentage_assessment_id: percentage_assessment.id,
        value: 0
      )
    end
    @object = assessment_result
    set_breadcrum_for_new
  end

  def create
    @object = AssessmentResult.new(assessment_result_params)
    set_breadcrum_for_new

    action = DocumentAction::AssessmentResult::Save.new(assessment_result: @object)
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

    @object.update(
      lecturer_id: assessment_result_params[:lecturer_id],
      assessor_id: assessment_result_params[:assessor_id]
    )
    assessment_result_params[:assessment_result_lines_attributes].each do |key, values|
      line = @object.assessment_result_lines.find_by_and_decorate(percentage_assessment_id: values[:percentage_assessment_id].to_i)
      line.update(value: BigDecimal.new(values[:value]))
    end

    assessment_result_calculator = AssessmentResultCalculator.new(assessment_result: @object)
    @object.update(weighting_value: assessment_result_calculator.weighting_value)
    @object.update(average_value: assessment_result_calculator.average_value)

    if @object.draft?
      @object.save ? redirect_to(@object) : render('edit')
    else
      edit_callback_for @object
    end
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