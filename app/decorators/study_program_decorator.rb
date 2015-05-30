class StudyProgramDecorator < ApplicationDecorator

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
        title: 'Fakultas',
        value: link_to_faculty
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

  def link_to_faculty
    h.link_to faculty.name, faculty
  end
end