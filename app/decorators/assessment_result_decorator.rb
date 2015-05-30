class AssessmentResultDecorator < ApplicationDecorator

  def action
    default_state_action
  end

  def data_to_show
    [
      {
        title: 'Kode',
        value: code,
        index: false
      },
      {
        title: 'Dosen',
        value: h.link_to(lecturer.try(:name), object)
      },
      {
        title: 'Nilai Pembobotan',
        value: weighting_value
      },
      {
        title: 'Nilai Rata-rata',
        value: average_value
      },
      {
        title: 'Penilai',
        value: h.link_to(assessor.try(:name), assessor)
      },

      {
        title: 'Tanggal Awal Penilaian',
        value: date_format_for(start_date)
      },
      {
        title: 'Tanggal Akhir Penilaian',
        value: date_format_for(end_date)
      },
      {
        title: 'Status',
        value: state
      }
    ]
  end

  def show_lines_data
    result = {
      header_data: [
        {
          title: 'Bobot Penilaian',
          key: :percentage_assessment_name
        },
        {
          title: 'Nilai',
          key: :percentage_assessment_value
        }
      ],
      body_data: []
    }
    PercentageAssessment.all.each do |percentage_assessment|
      percentage_assessment_name = percentage_assessment.name
      value = assessment_result_lines.find_by(percentage_assessment_id: percentage_assessment.id).try(:value)

      result[:body_data] << {
        percentage_assessment_name: percentage_assessment_name,
        percentage_assessment_value: value
      }
    end
    result
  end

end