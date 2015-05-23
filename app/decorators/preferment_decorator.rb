class PrefermentDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def index_data
    [
      {
        title: 'DP3',
        value: h.link_to(list_of_ratings_execution_of_work.code, list_of_ratings_execution_of_work)
      },
      {
        title: 'Pangkat Baru',
        value: h.link_to(rank_of_lecturer.name, rank_of_lecturer)
      },
      {
        title: 'No SK',
        value: decision_letter_number
      },
      {
        title: 'Tanggal Pengajuan Kenaikan Pangkat',
        value: date_format_for(submissions_preferment_date)
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'DP3',
        value: h.link_to(list_of_ratings_execution_of_work.code, list_of_ratings_execution_of_work)
      },
      {
        title: 'Pangkat Sebelumnya',
        value: h.link_to(current_rank_of_lecturer.name, current_rank_of_lecturer)
      },
      {
        title: 'Pangkat Baru',
        value: h.link_to(rank_of_lecturer.name, rank_of_lecturer)
      },
      {
        title: 'Masa Kerja',
        value: work_period_detail
      },
      {
        title: 'No SK Kenaikan Pangkat',
        value: decision_letter_number
      },
      {
        title: 'Tanggal Pengajuan Kenaikan Pangkat',
        value: date_format_for(submissions_preferment_date)
      },
      {
        title: 'Tanggal Kenaikan Pangkat',
        value: date_format_for(preferment_date)
      }
    ] + default_show_data
  end

  def work_period_detail
    year_work_period_value = year_work_period.present? ? year_work_period : '-'
    month_work_period_value = month_work_period.present? ? month_work_period : '-'
    day_work_period_value = day_work_period.present? ? day_work_period : '-'
    "#{year_work_period_value} Tahun, #{month_work_period_value} Bulan, #{day_work_period_value} Hari"
  end

end