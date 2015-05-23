class LecturerDecorator < ApplicationDecorator

  def action
    default_crud
  end

  def index_data
    [
      {
        title: 'NIK',
        value: registration_number_of_employees
      },
      {
        title: 'Nama',
        value: name
      }
    ] + default_index_data
  end

  def show_data
    [
      {
        title: 'NIK',
        value: object.registration_number_of_employees
      },
      {
        title: 'Nama',
        value: name
      },
      {
        title: 'Tempat Lahir',
        value: place_of_birth
      },
      {
        title: 'Tanggal Lahir',
        value: date_format_for(date_of_birth)
      },
      {
        title: 'Jenis Kelamin',
        value: gender
      },
      {
        title: 'Status',
        value: marital_status
      },
      {
        title: 'Nomor Kontak',
        value: contact_number
      },
      {
        title: 'Pendidikan',
        value: education
      },
      {
        title: 'Alamat',
        value: address_format
      },
      {
        title: 'Program Studi',
        value: link_to_study_program
      },
      {
        title: 'Jabatan',
        value: link_to_rank_of_lecturer
      }
    ] + default_show_data
  end

  def address_format
    addressess =  [ address_line1,
                    address_line2,
                    address_line3,
                    address_line4
                  ].reject{ |address| address == "" || address == nil }
    addressess.present? ? addressess.join("<br>").html_safe : '-'
  end

  def link_to_study_program
    h.link_to(study_program_name_by(@object.study_program_id), @object.study_program)
  end

  def link_to_rank_of_lecturer
    h.link_to(rank_of_lecturer_name_by(@object.rank_of_lecturer_id), @object.rank_of_lecturer)
  end

  def study_program_name_by(id)
    StudyProgram.find(id).name
  end

  def rank_of_lecturer_name_by(id)
    RankOfLecturer.find(id).name
  end

end