class PrefermentsController < ApplicationController
  include DefaultStateTransitionCallback

  before_filter :authenticate_user!, :set_page_title

  def index
    @object = Preferment.order(updated_at: :desc).page(params[:page]).per(10)
    generate_index_data_for @object
    set_breadcrumb_for_index
  end

  def show
    @object = find_by_and_decorate(params[:id])
    set_breadcrumb_for_show(@object)
  end

  def new
    @object = Preferment.new
    set_breadcrum_for_new
  end

  def create
    @object = Preferment.new(preferment_params)
    set_breadcrum_for_new

    action = Preferment::Action::Save.new(preferment: @object)
    action.run ? redirect_to(@object) : render('new')
  end

  def edit
    @object = find_by_and_decorate(params[:id])
    edit_callback_for @object
    set_breadcrumb_for_edit @object
  end

  def update
    @object = find_by_and_decorate(params[:id])
    update_callback_for @object, preferment_params
    set_breadcrumb_for_edit @object
  end

  def destroy
    @object = find_by_and_decorate(params[:id])
    destroy_callback_for @object
  end

  def confirm
    @object = find_by_and_decorate(params[:id])
    confirm_callback_for @object
  end

  def revise
    @object = find_by_and_decorate(params[:id])
    revise_callback_for @object
  end

  def cancel
    @object = find_by_and_decorate(params[:id])
    cancel_callback_for @object
  end

  def complete
    @object = find_by_and_decorate(params[:id])
    complete_callback_for @object
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