class RankOfLecturersController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @object = RankOfLecturer.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def new
    @object = RankOfLecturer.new
    set_breadcrum_for_new
  end

  def create
    @object = RankOfLecturer.new(rank_of_lecturer_params)
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

    @object.attributes = rank_of_lecturer_params
    @object.save ? redirect_to(@object) : render('edit')
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    @object.destroy ? redirect_to(@object) : redirect_to(faculties_path)
  end

private

  def find_by_and_decorate(id)
    decorate RankOfLecturer.find(id)
  end

  def rank_of_lecturer_params
    params.require(:rank_of_lecturer)
          .permit(
            :name,
            :description,
            :symbol,
            :basic_salary
          )
  end

  def set_page_title
    @page_title ||= 'Pangkat / Golongan'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, rank_of_lecturers_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb "#{object.name} - #{object.symbol}", rank_of_lecturer_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_rank_of_lecturer_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_rank_of_lecturer_url(object)
  end
end