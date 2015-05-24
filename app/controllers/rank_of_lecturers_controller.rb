class RankOfLecturersController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = RankOfLecturer.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
    set_breadcrumb_for_index
  end

  def new
    @object = RankOfLecturer.new
    set_breadcrum_for_new
  end

  def create
    @object = RankOfLecturer.new(rank_of_lecturer_params)
    set_breadcrum_for_new
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = RankOfLecturer.find(params[:id]).decorate
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = RankOfLecturer.find(params[:id])
    set_breadcrumb_for_edit(@object)
  end

  def update
    @object = RankOfLecturer.find(params[:id])
    set_breadcrumb_for_edit(@object)
    if @object.update(rank_of_lecturer_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = RankOfLecturer.find(params[:id])
    if @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

private

  def rank_of_lecturer_params
    params.require(:rank_of_lecturer).permit(:name, :description, :symbol)
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