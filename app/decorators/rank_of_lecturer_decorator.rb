class RankOfLecturerDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def index_data
    [
      {
        title: 'Nama',
        value: name
      },
      {
        title: 'Simbol',
        value: symbol
      },
      {
        title: 'Gaji Pokok',
        value: basic_salary_format
      }
    ] + default_index_data
  end

  def show_data
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
        value: description_raw
      }
    ] + default_show_data
  end

  def description_raw
    description.present? ? h.raw(description) : '-'
  end

end