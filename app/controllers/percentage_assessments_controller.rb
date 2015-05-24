class PercentageAssessmentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @paginate_object = PercentageAssessment.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
  end

  def new
    @object = PercentageAssessment.new
  end

  def create
    @object = PercentageAssessment.new(percentage_assessment_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = PercentageAssessment.find(params[:id]).decorate
  end

  def edit
    @object = PercentageAssessment.find(params[:id])
  end

  def update
    @object = PercentageAssessment.find(params[:id])
    if @object.update(percentage_assessment_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = PercentageAssessment.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def percentage_assessment_params
    params.require(:percentage_assessment).permit(:name, :description, :value)
  end
end