class FacultyDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def index_data
    [
      {
        title: 'Kode',
        value: code
      },
      {
        title: 'Name',
        value: name
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'Kode',
        value: code
      },
      {
        title: 'Name',
        value: name
      },
      {
        title: 'Deskripsi',
        value: description_raw
      }
    ] + default_show_data
  end

  def description_raw
    description.present? ? h.raw(description) : '-'
  end

end