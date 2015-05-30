class ListOfRatingsExecutionOfWorkDecorator < ApplicationDecorator

  def action
    [
      default_state_action,
      link_to_export_pdf
    ].join(" ").html_safe
  end

  def data_to_show
    [
      {
        title: 'Kode',
        value: code
      },
      {
        title: 'Dosen',
        value: link_to_lecturer
      },
      {
        title: 'Atasan Penilai',
        value: link_to_assessor
      },
      {
        title: 'Keberatan',
        value: objection_raw,
        index: false
      },
      {
        title: 'Tanggal Keberatan',
        value: date_format_for(objection_date),
        index: false
      },
      {
        title: 'Tanggapan',
        value: response_raw,
        index: false
      },
      {
        title: 'Tanggal Tanggapan',
        value: date_format_for(response_date),
        index: false
      },
      {
        title: 'Keputusan',
        value: decision_raw,
        index: false
      },
      {
        title: 'Tanggal Keputusan',
        value: date_format_for(decision_date),
        index: false
      },
      {
        title: 'Status',
        value: state
      }
    ]
  end

  def link_to_lecturer
    lecturer_name = lecturer_name_by(assessment_result.lecturer_id)
    h.link_to(lecturer_name, assessment_result.lecturer)
  end

  def link_to_assessor
    h.link_to(assessor.try(:name), assessor)
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
    h.link_to "Export PDF", url, class: "btn btn-success btn-sm" if object.completed?
  end

end