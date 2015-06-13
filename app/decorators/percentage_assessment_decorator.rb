class PercentageAssessmentDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def data_to_show
    [
      {
        title: 'Nama',
        value: h.link_to(name, object)
      },
      {
        title: 'Bobot Nilai',
        value: "#{value}%"
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