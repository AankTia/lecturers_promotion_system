class AssessorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @paginate_object = Assessor.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
  end

  def new
    @object = Assessor.new
  end

  def create
    @object = Assessor.new(assessor_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = Assessor.find(params[:id]).decorate
  end

  def edit
    @object = Assessor.find(params[:id])
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Penilai dalam status #{@object.state}"} unless @object.inactive?
  end

  def update
    @object = Assessor.find(params[:id])
    if @object.inactive? && @object.update(assessor_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = Assessor.find(params[:id])
    if @object.inactive? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def activate
    @object = Assessor.find(params[:id])
    if @object.can_activate?
      @object.activate!
      redirect_to @object, flash: {notice: "Berhasil mengaktifkan Penilai."}
    else
      redirect_to @object, flash: {alert: "Gagal mengaktifkan Penilai."}
    end
  end

  def deactivate
    @object = Assessor.find(params[:id])
    if @object.can_deactivate?
      @object.deactivate!
      redirect_to @object, flash: {notice: "Berhasil menonaktifkan Penilai."}
    else
      redirect_to @object, flash: {alert: "Gagal menonaktifkan Penilai."}
    end
  end

private

  def assessor_params
    params.require(:assessor).permit(:registration_number_of_employees,
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