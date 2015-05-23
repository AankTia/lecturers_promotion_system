class ListOfRatingsExecutionOfWorkDecorator < ApplicationDecorator

  def action
    [
      default_crud,
      link_to_export_pdf
    ].join(" ").html_safe
  end

  def index_data
    [
      {
        title: 'Dosen',
        value: h.link_to(lecturer_name_by(assessment_result.lecturer_id), assessment_result.lecturer)
      },
      {
        title: 'Atasan Penilai',
        value: h.link_to(assessor.try(:name), assessor)
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'Kode',
        value: code
      },
      {
        title: 'Dosen',
        value: h.link_to(lecturer_name_by(assessment_result.lecturer_id), object)
      },
      {
        title: 'Atasan Penilai',
        value: h.link_to(assessor.try(:name), assessor)
      },
      {
        title: 'Keberatan',
        value: objection_raw
      },
      {
        title: 'Tanggal Keberatan',
        value: date_format_for(objection_date)
      },
      {
        title: 'Tanggapan',
        value: response_raw
      },
      {
        title: 'Tanggal Tanggapan',
        value: date_format_for(response_date)
      },
      {
        title: 'Keputusan',
        value: decision_raw
      },
      {
        title: 'Tanggal Keputusan',
        value: date_format_for(decision_date)
      }
    ] + default_show_data
  end

  def lecturer_name_by(id)
    Lecturer.find(id).try(:name)
  end

  def objection_raw
    objection.present? ? h.raw(objection) : '-'
  end

  def response_raw
    response.present? ? h.raw(response) : '-'
  end

  def decision_raw
    decision.present? ? h.raw(decision) : '-'
  end

  def link_to_export_pdf
    url = h.send("export_pdf_#{object_name_singularize}_url",object)
    h.link_to "Export PDF", url, class: "btn btn-success btn-sm"
  end

end