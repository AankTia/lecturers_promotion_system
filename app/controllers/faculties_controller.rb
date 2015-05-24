class FacultiesController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = Faculty.order(updated_at: :desc).page(params[:page]).per(10)
    set_breadcrumb_for_index
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
  end

  def new
    @object = Faculty.new
    set_breadcrum_for_new
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
    set_breadcrumb_for_show @object
  end

  def edit
    @object = Faculty.find(params[:id])
    set_breadcrumb_for_edit(@object)
  end

  def update
    @object = Faculty.find(params[:id])
    set_breadcrumb_for_edit(@object)
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

  def set_page_title
    @page_title ||= 'Fakultas'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, faculties_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb "#{object.code} - #{object.name}", faculty_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_faculty_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_faculty_url(object)
  end
end