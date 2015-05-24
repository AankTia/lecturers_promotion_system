class ApplicationDecorator < Draper::Decorator
  include UrlDecorator

  delegate_all
  delegate :current_page, :total_pages, :limit_value

  def default_crud
    [
      link_to_new,
      link_to_edit,
      link_to_destroy
    ].join(" ").html_safe
  end

  def default_state_action
    [
      link_to_new,
      (object.draft? ? link_to_edit : ''),
      (object.draft? ? link_to_destroy : ''),
      link_to_confirm,
      link_to_revise,
      link_to_cancel,
      link_to_complete
    ].join(" ").html_safe
  end

  def active_inactive_state_action
    [
      link_to_new,
      (object.inactive? ? link_to_edit : ''),
      (object.inactive? ? link_to_destroy : ''),
      link_to_activate,
      link_to_deactivate
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

  def default_state_index_data
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
        value: (object.draft? ? link_to_edit : '')
      },
      {
        title: '',
        value: (object.draft? ? link_to_destroy : '')
      }
    ]
  end

  def active_inactive_state_index_data
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
        value: (object.inactive? ? link_to_edit : '')
      },
      {
        title: '',
        value: (object.inactive? ? link_to_destroy : '')
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

  def link_to_confirm
    h.link_to "Confirm", confirm_object_url, method: :post, class: "btn btn-info btn-sm" if object.can_confirm?
  end

  def link_to_revise
    h.link_to "Revise", revise_object_url, method: :post, class: "btn btn-warning btn-sm" if object.can_revise?
  end

  def link_to_cancel
    h.link_to "Cancel", cancel_object_url, method: :post, class: "btn btn-danger btn-sm" if object.can_cancel?
  end

  def link_to_complete
    h.link_to "Complete", complete_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_cancel?
  end

  def link_to_activate
    h.link_to "Activate", activate_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_activate?
  end

  def link_to_deactivate
    h.link_to "Deactivate", deactivate_object_url, method: :post, class: "btn btn-success btn-sm" if object.can_deactivate?
  end

  def created_at_format
    date_format_for(created_at)
  end

  def updated_at_format
    date_format_for(updated_at)
  end

  def date_format_for(date)
    date.present? ? date.strftime("%d %B %Y") : '-'
  end

end