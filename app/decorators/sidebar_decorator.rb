class SidebarDecorator < ApplicationDecorator

  SIDEBAR = {
    master: {
      group_menu_title: 'Master',
      child_menu: [
        { title: 'Fakultas', string_path: 'faculties_path' },
        { title: 'Program Studi', string_path: 'study_programs_path' },
        { title: 'Pangkat / Golongan', string_path: 'rank_of_lecturers_path' },
        { title: 'Penilai', string_path: 'assessors_path' },
        { title: 'Dosen', string_path: 'lecturers_path' }
      ]
    },
    assessment: {
      group_menu_title: 'Penilaian',
      child_menu: [
        { title: 'Waktu Penilaian', string_path: 'assessment_ranges_path' },
        { title: 'Bobot Penilain', string_path: 'percentage_assessments_path' },
        { title: 'Penilain', string_path: 'assessment_results_path' },
        { title: 'Daftar Penilaian Pelaksanaan Pekerjaan (DP3)', string_path: 'list_of_ratings_execution_of_works_path' },
        { title: 'Kenaikan Pangkat', string_path: 'preferments_path' },
        { title: 'Kenaikan Pangkat Berkala', string_path: 'periodic_preferments_path' }
      ]
    }
  }

  def initialize(params:, resources: nil)
    @params = params
    @result = []

    SIDEBAR.each do |key, value|
      generate_group_menu(group: key, details: value)
    end
  end

  def to_html
    @result.join('').html_safe
  end

private

  def generate_group_menu(group:, details:)
    title = details[:group_menu_title]
    icon = icon_for(group)
    @result << group_link_template(title: title,
                                   icon: icon,
                                   child_menu: details[:child_menu])
  end

  def generate_menu(child_menu)
    results = []
    child_menu.each do |menu|
      title = menu[:title]
      url = h.send("#{menu[:string_path]}")
      style_class = (url.gsub('/','') == @params[:controller]) ? 'current_page' : ''
      link = h.link_to(title, url, class: style_class)
      results << h.content_tag(:li, link, class: style_class)
    end
    results.join('').html_safe
  end

  def icon_for(group_menu)
    case group_menu
    when :master
      "fa fa-edit"
    when :assessment
      "fa fa-bar-chart-o"
    else
      ""
    end
  end

  def group_link_template(title:, icon:, child_menu: )
    style_klass = style_menu_class(child_menu)

    result = "<li class='#{style_klass[:active_class]}'>
      <a>
        <i class='#{icon}'></i>
        #{title} <span class=\"fa fa-chevron-down\"></span>
      </a>
      <ul class=\"nav child_menu\" style='#{style_klass[:style]}'>
        #{generate_menu(child_menu)}
      </ul>
    </li>".html_safe

    result
  end

  def style_menu_class(child_menu)
    child_menu_controller = child_menu.map{|menu| menu[:string_path].gsub('_path','')}
    if child_menu_controller.include?(@params[:controller])
      { active_class: 'active', style: 'display: block; padding-top: 0px; margin-top: 0px; padding-bottom: 0px; margin-bottom: 0px; overflow: hidden;'}
    else
      { active_class: '', style: 'display: none;'}
    end
  end
end