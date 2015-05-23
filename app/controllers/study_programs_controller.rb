class StudyProgramsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = StudyProgram.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
  end

  def new
    @object = StudyProgram.new
  end

  def create
    @object = StudyProgram.new(study_program_params) 
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = StudyProgram.find(params[:id]).decorate
  end

  def edit
    @object = StudyProgram.find(params[:id])
  end

  def update
    @object = StudyProgram.find(params[:id])
    if @object.update(study_program_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = StudyProgram.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def study_program_params
    params.require(:study_program).permit(:faculty_id, :code, :name, :description)
  end
end