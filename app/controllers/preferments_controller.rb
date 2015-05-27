class PrefermentsController < ApplicationController
  before_filter :authenticate_user!, :set_page_title

  def index
    @paginate_object = Preferment.order(updated_at: :desc).page(params[:page]).per(10)
    @index_data = []
    decorated_objects = decorate @paginate_object
    decorated_objects.each {|o| @index_data << o.index_data}
    set_breadcrumb_for_index
  end

  def new
    @object = Preferment.new
    set_breadcrum_for_new
  end

  def create
    @object = Preferment.new(preferment_params)
    set_breadcrum_for_new
    action = Preferment::Save.new(preferment: @object)
    if action.run
      redirect_to @object
    else
      render 'new'
    end
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
    redirect_to @object, flash: {alert: "Tidak bisa memperbaharui Kenaikan Pangkat."} unless @object.draft?
  end

  def update
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_edit(@object)
    if @object.draft? && @object.update(preferment_params)
      redirect_to @object
    else
      render 'edit'
    end
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    if @object.draft? && @object.destroy
      redirect_to @object
    else
      redirect_to faculties_path
    end
  end

  def confirm
    @object = find_by_and_decorate(params[:id])
    if @object.can_confirm?
      @object.confirm!
      redirect_to @object, flash: {notice: "Confirm Kenaikan Pangkat Success"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat tidak bisa di Confirm"}
    end
  end

  def revise
    @object = find_by_and_decorate(params[:id])
    if @object.can_revise?
      @object.revise!
      redirect_to @object, flash: {notice: "Revise Kenaikan Pangkat Success"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat tidak bisa di Revise"}
    end
  end

  def cancel
    @object = find_by_and_decorate(params[:id])
    if @object.can_cancel?
      @object.cancel!
      redirect_to @object, flash: {notice: "Kenaikan Pangkat berhasil di di batalkan"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat tidak bisa di batalkan"}
    end
  end

  def complete
    @object = find_by_and_decorate(params[:id])
    if @object.can_complete?
      @object.complete!
      redirect_to @object, flash: {notice: "Kenaikan Pangkat Complete"}
    else
      redirect_to @object, flash: {alert: "Kenaikan Pangkat tidak bisa Complete"}
    end
  end

private

  def find_by_and_decorate(id)
    decorate Preferment.find(id)
  end

  def preferment_params
    params.require(:preferment)
          .permit(
            :list_of_ratings_execution_of_work_id,
            :rank_of_lecturer_id,
            :decision_letter_number,
            :submissions_preferment_date,
            :preferment_date
          )
  end

  def set_page_title
    @page_title ||= 'Kenaikan Pangkat'
  end

  def set_breadcrumb_for_index
    add_breadcrumb @page_title, preferments_url
  end

  def set_breadcrumb_for_show(object)
    set_breadcrumb_for_index
    add_breadcrumb object.decision_letter_number, preferment_url(object)
  end

  def set_breadcrum_for_new
    set_breadcrumb_for_index
    add_breadcrumb "Buat Baru", new_faculty_url
  end

  def set_breadcrumb_for_edit(object)
    set_breadcrumb_for_show(object)
    add_breadcrumb "Perbaharui", edit_preferment_url(object)
  end
end