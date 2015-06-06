class AssessmentResultDecorator < ApplicationDecorator

  def action
    [
      default_state_action,
      link_to_create_list_of_ratings_execution_of_work
    ].join(" ").html_safe
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
        value: date_format_for(assessment_range.start_date)
      },
      {
        title: 'Tanggal Akhir Penilaian',
        value: date_format_for(assessment_range.end_date)
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

  def link_to_create_list_of_ratings_execution_of_work
    url = h.send("create_list_of_ratings_execution_of_work_#{object_name_singularize}_url",object)
    h.link_to "Buat DP3", url, method: :post, class: "btn btn-info btn-sm" if object.state == 'completed'
  end

end