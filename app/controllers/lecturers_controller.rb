class LecturersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = Lecturer.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
  end

  def new
    @object = Lecturer.new
  end

  def create
    @object = Lecturer.new(lecturer_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = Lecturer.find(params[:id]).decorate
  end

  def edit
    @object = Lecturer.find(params[:id])
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Dosen dalam status #{@object.state}"} unless @object.inactive?
  end

  def update
    @object = Lecturer.find(params[:id])
    if @object.inactive? && @object.update(lecturer_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = Lecturer.find(params[:id])
    if @object.inactive? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def activate
    @object = Lecturer.find(params[:id])
    if @object.can_activate?
      @object.activate!
      redirect_to @object, flash: {notice: "Berhasil mengaktifkan Dosen."}
    else
      redirect_to @object, flash: {alert: "Gagal mengaktifkan Dosen."}
    end
  end

  def deactivate
    @object = Lecturer.find(params[:id])
    if @object.can_deactivate?
      @object.deactivate!
      redirect_to @object, flash: {notice: "Berhasil menonaktifkan Dosen."}
    else
      redirect_to @object, flash: {alert: "Gagal menonaktifkan Dosen."}
    end
  end

private

  def lecturer_params
    params.require(:lecturer).permit(:registration_number_of_employees,
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
                                     :contact_number)
  end
end