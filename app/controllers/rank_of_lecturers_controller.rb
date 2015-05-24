class RankOfLecturersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @paginate_object = RankOfLecturer.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = @paginate_object.decorate
    decorated_objects.each {|o| @index_data << o.index_data}
  end

  def new
    @object = RankOfLecturer.new
  end

  def create
    @object = RankOfLecturer.new(rank_of_lecturer_params)
    if @object.save
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = RankOfLecturer.find(params[:id]).decorate
  end

  def edit
    @object = RankOfLecturer.find(params[:id])
  end

  def update
    @object = RankOfLecturer.find(params[:id])
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
    params.require(:rank_of_lecturer).permit(:name, :description, :symbol_of_rank)
  end
end