class AssessorDecorator < ApplicationDecorator

  def action
    active_inactive_state_action
  end

  def data_to_show
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
        value: place_of_birth,
        index: false
      },
      {
        title: 'Tanggal Lahir',
        value: date_format_for(date_of_birth),
        index: false
      },
      {
        title: 'Jenis Kelamin',
        value: gender,
        index: false
      },
      {
        title: 'Status Pernikahan',
        value: marital_status,
        index: false
      },
      {
        title: 'Nomor Kontak',
        value: contact_number,
        index: false
      },
      {
        title: 'Pendidikan',
        value: education,
        index: false
      },
      {
        title: 'Alamat',
        value: address_format,
        index: false
      },
      {
        title: 'Program Studi',
        value: link_to_study_program,
        index: false
      },
      {
        title: 'Jabatan',
        value: link_to_rank_of_lecturer,
        index: false
      },
      {
        title: 'Tanggal Masuk',
        value: date_format_for(date_of_addmission),
        index: false
      },
      {
        title: 'Status',
        value: state
      }
    ]
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