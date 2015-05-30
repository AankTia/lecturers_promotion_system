require "prawn/table"
class PeriodicPreferment::Pdf < Prawn::Document
  attr_reader :object

  def initialize(object:)
    @object = object
    super(page_layout: :portrait, left_margin: 50, right_margin: 50, top_margin: 50, bottom_margin: 50)

    print_header
    print_body
    print_footer
  end

private

  def print_header
    table(
      [
        [
          description_table,
          "Kuningan, #{Time.now.strftime("%d %B %Y")}"]
      ],
      width: bounds.width,
      cell_style: {
        borders: [],
        padding: 0
      }
    ) do
        column(1).align = :right
      end

    move_down 25
  end

  def description_table
    make_table(
      [
        ['Nomor',':',"#{object.periodic_preferment_number}"],
        ['Hal',':','Kenaikan gaji berkala']
      ],
      cell_style: {
        borders: []
      }
    )
  end

  def print_body
    preferment = object.preferment
    list_of_ratings_execution_of_work = preferment.list_of_ratings_execution_of_work
    assessment_result = list_of_ratings_execution_of_work.assessment_result
    lecturer = assessment_result.lecturer
    study_program = lecturer.study_program
    faculty = study_program.faculty

    text "Yth. Dekan #{faculty.name}
          Universitas Kuningan
          di
          Kuningan

          Menindaklanjuti surat Saudara, Nomor #{preferment.decision_letter_number}, tanggal #{date_format_for(preferment.updated_at)}, perihal kenaikan gaji berkala untuk pegawai dengan biodata sebagai berikut:
          "

    table(
      [
        ['Nama',':',lecturer.name],
        ['NIK',':',lecturer.registration_number_of_employees],
        ['Jabatan',':',lecturer.rank_of_lecturer.name],
        ['TMT',':',lecturer.date_of_addmission],
        ['Masa Kerja',':',''],
        ['Pendidikan',':',lecturer.education]
      ],
      cell_style: {
        borders: []
      }
    )

    text "
          Sehubungan yang bersangkutan saat ini telah memenuhi masa kerja dan syarat lainnya. Sehingga bersangkutan dapat diusulkan gaji pokok baru mulai tanggal #{date_format_for(preferment.submissions_preferment_date)} sebesar #{preferment.rank_of_lecturer.basic_salary_format}. Kenaikan berala berikutnya pada tanggapl #{date_format_for(object.periodic_preferment_date)}

          Demikian, mohon menjadi maklum.
         "

    table(
      [
        ['',
         'Kepala BAAKSP



         XXXXXXX
         NIK. xxxx'
        ]
      ],
      width: bounds.width,
      cell_style: {
        borders: []
      },
      column_widths: {
        0 => bounds.width/2,
        1 => bounds.width/2,
      }
    ) do
        column(1).align = :center
      end
  end

  def print_footer
    text "Tembusan:
          1. Rektor Universitas Kuningan
          2. Sdr. Yang bersangkutan"
  end

  def date_format_for(date)
    date.strftime("%d %B %Y")
  end

end