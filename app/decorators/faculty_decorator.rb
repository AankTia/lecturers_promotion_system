class FacultyDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def data_to_show
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
        value: description_raw,
        index: false
      }
    ]
  end

  def description_raw
    description.present? ? h.raw(description) : '-'
  end

end