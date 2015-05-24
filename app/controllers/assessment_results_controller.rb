class AssessmentResultsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = AssessmentResult.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
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
  end

  def create
    @object = AssessmentResult.new(assessment_result_params)
    action = DocumentAction::AssessmentResult::Save.new(assessment_result: @object)
    if action.run
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = AssessmentResult.find(params[:id]).decorate
  end

  def edit
    @object = AssessmentResult.find(params[:id])
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Penilaian"} unless @object.draft?
  end

  def update
    @object = AssessmentResult.find(params[:id])
    @object.update(
      lecturer_id: assessment_result_params[:lecturer_id],
      assessor_id: assessment_result_params[:assessor_id]
    )
    assessment_result_params[:assessment_result_lines_attributes].each do |key, values|
      line = @object.assessment_result_lines.find_by(percentage_assessment_id: values[:percentage_assessment_id].to_i)
      line.update(value: BigDecimal.new(values[:value]))
    end

    assessment_value = AssessmentResultCalculator.new(assessment_result: @object).assessment_value
    @object.update(value: assessment_value)

    if @object.draft? && @object.save
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = AssessmentResult.find(params[:id])
    if @object.draft? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def confirm
    @object = AssessmentResult.find(params[:id]).decorate
    if @object.can_confirm?
      @object.confirm!
      redirect_to @object, flash: {notice: "Confirm Penilaian Success"}
    else
      redirect_to @object, flash: {alert: "Penilaian tidak bisa di Confirm"}
    end
  end

  def revise
    @object = AssessmentResult.find(params[:id]).decorate
    if @object.can_revise?
      @object.revise!
      redirect_to @object, flash: {notice: "Revise Penilaian Success"}
    else
      redirect_to @object, flash: {alert: "Penilaian tidak bisa di Revise"}
    end
  end

  def cancel
    @object = AssessmentResult.find(params[:id]).decorate
    if @object.can_cancel?
      @object.cancel!
      redirect_to @object, flash: {notice: "Penilaian berhasil di di batalkan"}
    else
      redirect_to @object, flash: {alert: "Penilaian tidak bisa di batalkan"}
    end
  end

  def complete
    @object = AssessmentResult.find(params[:id]).decorate
    if @object.can_complete?
      @object.complete!
      redirect_to @object, flash: {notice: "Penilaian Complete"}
    else
      redirect_to @object, flash: {alert: "Penilaian tidak bisa Complete"}
    end
  end

private

  def assessment_result_params
    params.require(:assessment_result)
          .permit(:lecturer_id,
                  :assessor_id,
                  :start_date,
                  :end_date,
                  assessment_result_lines_attributes: [
                    :percentage_assessment_id,
                    :value,
                    :_destroy
                  ])
  end
end