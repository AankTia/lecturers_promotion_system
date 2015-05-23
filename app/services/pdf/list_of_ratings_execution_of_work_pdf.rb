require "prawn/table"
class Pdf::ListOfRatingsExecutionOfWorkPdf < Prawn::Document
  attr_reader :object

  def initialize(object:)
    @object = object
    super(page_layout: :portrait, left_margin: 50, right_margin: 50, top_margin: 50, bottom_margin: 50)

    print_header
    print_body
  end

private

  def print_header
    image "#{Rails.root}/app/assets/images/logo_universitas_kuningan.jpg",
      position: :center,
      width: 100

    move_down 25

    text 'RAHASIA',
      align: :center,
      style: :bold,
      size: 11

    move_down 25

    pdf_title
  end

  def print_body
    move_down 25

    text "Jangka Waktu Penilaian:\n#{date_format_for(assessment_result.start_date)} - #{date_format_for(assessment_result.end_date)}",
      size: 11

    move_down 10
    font_size 11
    table(
      [
        ['1', emplotee_table],
        ['2', assessor_official_table],
        ['3', head_of_assessor_official_table],
        ['4', assessment],
      ],
      width: bounds.width,
      column_widths: {
        0 => 20
      },
    )
  end

  def pdf_title
    text "DAFTAR PENILAIAN PELAKSANAAN PEKERJAAN\nCALON PEGAWAI TETAP YAYASAN",
      align: :center,
      style: :bold,
      size: 13
  end

  def emplotee_table
    study_program = lecturer.study_program
    faculty = study_program.faculty
    work_unit = "#{faculty.name} - #{study_program.name}"

    make_table(
      [
        ['YANG DINILAI'],
        ['Nama', lecturer.name],
        ['Tempat/Tanggal Lahir',  "#{lecturer.place_of_birth} / #{date_format_for(lecturer.date_of_birth)}"],
        ['NIK',  lecturer.registration_number_of_employees],
        ['Jabatan Pekerjaan',  lecturer.rank_of_lecturer.name],
        ['Unit Kerja', work_unit]
      ],
      width: bounds.width - 20,
      column_widths: {
        0 => 150
      }
    ) do
        row(0).font_style = :bold
        row(0).borders = []
      end
  end

  def assessor_official_table
    study_program = assessor.study_program
    faculty = study_program.faculty
    assessor_work_unit = "#{faculty.name} - #{study_program.name}"

    make_table(
      [
        ['PEJABAT PENILAI'],
        ['Nama', assessor.name],
        ['NIK', assessor.registration_number_of_employees],
        ['Jabatan Pekerjaan', assessor.rank_of_lecturer.name],
        ['Unit Organisasi', '']
      ],
      width: bounds.width - 20,
      column_widths: {
        0 => 150
      },
      cell_style: {
        overflow: :shrink_to_fit
      }
    ) do
        row(0).font_style = :bold
        row(0).borders = []
      end
  end

  def head_of_assessor_official_table
    make_table(
      [
        ['ATASAN PEJABAT PENILAI'],
        ['Nama', head_of_accessor.name],
        ['NIK', head_of_accessor.registration_number_of_employees],
        ['Jabatan Pekerjaan', head_of_accessor.rank_of_lecturer.name],
        ['Unit Organisasi', '']
      ],
      width: bounds.width - 20,
      column_widths: {
        0 => 150
      }
    ) do
        row(0).font_style = :bold
        row(0).borders = []
      end
  end

  def assessment
    table_data = [
      ['HASIL PENILAIAN'],
      ['Unusur Yang Dinilai','Nilai Angka', 'Nilai Sebutan', 'Keterangan']
    ]

    assessment_result.assessment_result_lines.each do |line|
      percentage_assessment = line.percentage_assessment
      table_data << [line.percentage_assessment.name, line.value, '', percentage_assessment.description]
    end

    table_data << ['Jumlah', assessment_result.assessment_result_lines.sum(:value),'','']
    table_data << ['Nilai Rata-Rata', assessment_result.assessment_result_lines.average(:value),'','']

    make_table(
      table_data,
      width: bounds.width - 20,
      column_widths: {
        0 => 150
      }
    ) do
        row(0).font_style = :bold
        row(0).borders = []
      end
  end

  def date_format_for(date)
    date.to_formatted_s(:long)
  end

  def assessment_result
    @assessment_result ||= object.assessment_result
  end

  def lecturer
    @lecturer ||= assessment_result.lecturer
  end

  def assessor
    @assessor ||= assessment_result.assessor
  end

  def head_of_accessor
    @head_of_accessor ||= object.assessor
  end
end