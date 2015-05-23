class PercentageAssessmentDecorator < ApplicationDecorator

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
        title: 'Bobot Nilai (%)',
        value: value
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'Nama',
        value: h.link_to(name, object)
      },
      {
        title: 'Bobot Nilai (%)',
        value: value
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