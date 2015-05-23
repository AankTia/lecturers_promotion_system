class ApplicationDecorator < Draper::Decorator
  include UrlDecorator

  delegate_all

  def default_crud
    [
      link_to_new,
      link_to_edit,
      link_to_destroy
    ].join(" ").html_safe
  end

  def default_index_data
    [
      {
        title: 'Tanggal Dibuat',
        value: created_at_format
      },
      {
        title: 'Tanggal Diperbaharui',
        value: updated_at_format
      },
      {
        title:'',
        value: link_to_show
      },
      {
        title: '',
        value: link_to_edit
      },
      {
        title: '',
        value: link_to_destroy
      }
    ]
  end

  def default_show_data
    [
      {
        title: 'Tanggal Dibuat',
        value: created_at_format
      },
      {
        title: 'Tanggal Diperbaharui',
        value: updated_at_format
      }
    ]
  end

  def link_to_show
    h.link_to "Detail", show_object_url, class: "btn btn-info btn-sm"
  end

  def link_to_new
    h.link_to "Buat Baru", new_object_url, class: "btn btn-primary btn-sm"
  end

  def link_to_edit
    h.link_to "Perbaharui", edit_object_url, class: "btn btn-warning btn-sm"
  end

  def link_to_destroy
    h.link_to 'Hapus', destroy_object_url,  method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-danger btn-sm"
  end

  def created_at_format
    date_format_for(created_at)
  end

  def updated_at_format
    date_format_for(updated_at)
  end

  def date_format_for(date)
    # date.present? ? date.to_formatted_s(:long) : '-'
    date.present? ? date.strftime("%d %B %Y") : '-'
  end

end