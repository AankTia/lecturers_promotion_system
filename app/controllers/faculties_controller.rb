class FacultiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @paginate_object = Faculty.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
  end

  def new
    @object = Faculty.new
  end

  def create
    @object = Faculty.new(faculty_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = Faculty.find(params[:id]).decorate
  end

  def edit
    @object = Faculty.find(params[:id])
  end

  def update
    @object = Faculty.find(params[:id])
    if @object.update(faculty_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = Faculty.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def faculty_params
    params.require(:faculty).permit(:code, :name, :description)
  end
end