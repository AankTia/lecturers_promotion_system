class StudyProgramsController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @object = StudyProgram.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def new
    @object = StudyProgram.new
    set_breadcrum_for_new
  end

  def create
    @object = StudyProgram.new(study_program_params)
    set_breadcrum_for_new

    @object.save ? redirect_to(@object) : render('new')
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show @object
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit @object
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit @object

    @object.attributes = study_program_params
    @object.save ? redirect_to(@object) : render('edit')
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    @object.destroy ? redirect_to(@object) : redirect_to(faculties_path)
  end

private

  def find_by_and_decorate(id)
    decorate StudyProgram.find(id)
  end

  def study_program_params
    params.require(:study_program)
          .permit(
            :faculty_id,
            :code,
            :name,
            :education_level,
            :description
          )
  end

  def set_page_title
    @page_title ||= 'Program Studi'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, study_programs_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb "#{object.code} - #{object.name}", study_program_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_faculty_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_study_program_url(object)
  end
end