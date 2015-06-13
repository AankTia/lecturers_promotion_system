class LecturersController < ApplicationController
  include ActiveInactiveStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = Lecturer.order(updated_at: :desc).decorate
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    @object = Lecturer.new
    set_breadcrum_for_new
  end

  def create
    @object = Lecturer.new(lecturer_params)
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
    update_callback_for @object, lecturer_params
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
    decorate Lecturer.find(id)
  end

  def lecturer_params
    params.require(:lecturer)
          .permit(
            :registration_number_of_employees,
            :study_program_id,
            :rank_of_lecturer_id,
            :name,
            :place_of_birth,
            :date_of_birth,
            :gender,
            :marital_status,
            :address_line_1,
            :address_line_2,
            :address_line_3,
            :address_line_4,
            :position,
            :education,
            :date_of_addmission,
            :contact_number
          )
  end

  def set_page_title
    @page_title ||= 'Dosen'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, lecturers_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.name, lecturer_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_lecturer_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_lecturer_url(object)
  end
end