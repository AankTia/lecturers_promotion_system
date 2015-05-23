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

    if @object.save
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = AssessmentResult.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
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