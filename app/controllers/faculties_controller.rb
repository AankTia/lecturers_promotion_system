class FacultiesController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @object = Faculty.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def new
    @object = Faculty.new
    set_breadcrum_for_new
  end

  def create
    @object = Faculty.new(faculty_params)
    set_breadcrum_for_new

    @object.save ? redirect_to(@object) : render('new')
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show @object
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)

    @object.attributes = faculty_params
    @object.save ? redirect_to(@object) : render('edit')
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def find_by_and_decorate(id)
    decorate Faculty.find(id)
  end

  def faculty_params
    params.require(:faculty)
          .permit(
            :code,
            :name,
            :description
          )
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