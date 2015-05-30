class RankOfLecturerDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def data_to_show
    [
      {
        title: 'Nama',
        value: h.link_to(object.name, object)
      },
      {
        title: 'Simbol',
        value: object.symbol
      },
      {
        title: 'Gaji Pokok',
        value: basic_salary_format
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