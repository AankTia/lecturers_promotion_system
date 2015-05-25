class LecturersController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = Lecturer.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = decorate @paginate_object
    decorated_objects.each {|o| @index_data << o.index_data}
    set_breadcrumb_for_index
  end

  def new
    @object = Lecturer.new
    set_breadcrum_for_new
  end

  def create
    @object = Lecturer.new(lecturer_params)
    set_breadcrum_for_new
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Dosen dalam status #{@object.state}"} unless @object.inactive?
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
    if @object.inactive? && @object.update(lecturer_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    if @object.inactive? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def activate
    @object = find_by_and_decorate(params[:id])
    if @object.can_activate?
      @object.activate!
      redirect_to @object, flash: {notice: "Berhasil mengaktifkan Dosen."}
    else
      redirect_to @object, flash: {alert: "Gagal mengaktifkan Dosen."}
    end
  end

  def deactivate
    @object = find_by_and_decorate(params[:id])
    if @object.can_deactivate?
      @object.deactivate!
      redirect_to @object, flash: {notice: "Berhasil menonaktifkan Dosen."}
    else
      redirect_to @object, flash: {alert: "Gagal menonaktifkan Dosen."}
    end
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