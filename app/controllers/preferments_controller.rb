class PrefermentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @object = Preferment.all.order(updated_at: :desc).decorate
    @index_data = []
    @object.each {|o| @index_data << o.index_data}
  end

  def new
    @object = Preferment.new
  end

  def create
    @object = Preferment.new(preferment_params)
    action = Preferment::Save.new(preferement: @object)
    # if @object.save
    if action.run
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = Preferment.find(params[:id]).decorate
  end

  def edit
    @object = Preferment.find(params[:id])
  end

  def update
    @object = Preferment.find(params[:id])
    if @object.update(preferment_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = Preferment.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def preferment_params
    params.require(:preferment)
          .permit(:list_of_ratings_execution_of_work_id,
                  :rank_of_lecturer_id,
                  :decision_letter_number,
                  :submissions_preferment_date,
                  :preferment_date)
  end
end