class AssessmentRangeDecorator < ApplicationDecorator

  def action
    active_inactive_state_action
  end

  def data_to_show
    [
      {
        title: 'Kode',
        value: code
      },
      {
        title: 'Waktu Mulai',
        value: date_format_for(start_date)
      },
      {
        title: 'Waktu Akhir',
        value: date_format_for(end_date)
      },
      {
        title: 'Deskripsi',
        value: description_raw,
        index: false
      },
      {
        title: 'Status',
        value: state
      }
    ]
  end

  def description_raw
    description.present? ? h.raw(description) : '-'
  end

end