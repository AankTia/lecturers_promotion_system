class AssessorsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = Assessor.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
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
  end

  def update
    @object = Assessor.find(params[:id])
    if @object.update(assessor_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = Assessor.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
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