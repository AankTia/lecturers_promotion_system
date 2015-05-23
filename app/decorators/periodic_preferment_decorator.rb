class PeriodicPrefermentDecorator < ApplicationDecorator

  def action
    [
      default_crud,
      link_to_export_pdf
    ].join(" ").html_safe
  end

  def index_data
    [
      {
        title: 'No SK Kenaikan Pangkat',
        value: h.link_to(preferment.decision_letter_number, preferment)
      },
      {
        title: 'No SK Kenaikan Pangkat Berkala',
        value: periodic_preferment_number
      },
      {
        title: 'Tanggal Kenaikan Pangkat Berkala',
        value: date_format_for(periodic_preferment_date)
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'No SK Kenaikan Pangkat',
        value: h.link_to(preferment.decision_letter_number, preferment)
      },
      {
        title: 'No SK Kenaikan Pangkat Berkala',
        value: periodic_preferment_number
      },
      {
        title: 'Tanggal Kenaikan Pangkat Berkala',
        value: date_format_for(periodic_preferment_date)
      }
    ] + default_show_data
  end

  def link_to_export_pdf
    url = h.send("export_pdf_#{object_name_singularize}_url",object)
    h.link_to "Export Surat Kenaikan Pangkat Berkala", url, class: "btn btn-success btn-sm"
  end

end