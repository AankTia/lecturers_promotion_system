# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

EDUCATION = ['SMA', 'Diploma', 'Sarjana', 'Magister', 'Doctor']
GENDER = ['Laki-laki', 'Perempuan']
DATE_OF_BIRTH_RANGE = Date.new(1970, 01, 01)..Date.new(1980, 01, 01)
DATE_OF_ADDMISSION_RANGE = Date.new(1990, 01, 01)..Date.new(2015, 01, 01)
MARITAL_STATUS = ['Lajang', 'Menikah', 'Bercerai']

# User seeds
  puts "Seed User..."
  user = User.new(email: 'test@mail.com', password: '123')

  user = User.new(
    username: "admin",
    first_name:  "Administrator",
    last_name:   "System",
    email:       "admin@web.com",
    password:    "password",
    password_confirmation: "password"
  )
  user.save!

# Faculty seeds
  puts "Seed Faculty..."
  [ {code: 'FKIP', name: 'Fakultas Keguruan dan Ilmu Pendidikan'},
    {code: 'FE', name: 'Fakultas Ekonomi'},
    {code: 'FKOM', name: 'Fakultas Ilmu Komputer'},
    {code: 'FHUT', name: 'Fakultas Kehutanan'},
    {code: 'FH', name: 'Fakultas Hukum'}
  ].each do |faculty|
    Faculty.new(code: faculty[:code], name: faculty[:name]).save
  end

# Study Program seeds
  puts "Seed Study Program..."
  [ {code: 'FKIP-PBSI-S1', name: 'Pendidikan Bahasa dan Sastra Indonesia ', faculty_code: 'FKIP'},
    {code: 'FKIP-PB-S1', name: 'Pendidikan Biologi', faculty_code: 'FKIP'},
    {code: 'FKIP-PE-S1', name: 'Pendidikan Ekonomi', faculty_code: 'FKIP'},
    {code: 'FKIP-PBI-S1', name: 'Pendidikan Bahasa Inggris', faculty_code: 'FKIP'},
    {code: 'FKIP-PGDS-S1', name: 'Pendidikan Guru Sekolah Dasar', faculty_code: 'FKIP'},
    {code: 'FKIP-PM-S1', name: 'Pendidikan Matematika', faculty_code: 'FKIP'},
    {code: 'FE-M-S1', name: 'Manajemen', faculty_code: 'FE'},
    {code: 'FE-A-S1', name: 'Akuntansi', faculty_code: 'FE'},
    {code: 'FHUT-IK-S1', name: 'Ilmu Kehutanan', faculty_code: 'FHUT'},
    {code: 'FKOM-TI-S1', name: 'Teknik Informatika', faculty_code: 'FKOM'},
    {code: 'FKOM-SI-S1', name: 'Sistem Informasi', faculty_code: 'FKOM'},
    {code: 'FKOM-TI-D3', name: 'Teknik Informatika (D3)', faculty_code: 'FKOM'},
    {code: 'FKOM-MI-D3', name: 'Manajemen Informatika (D3)', faculty_code: 'FKOM'},
    {code: 'FH-IH-S1', name: 'Ilmu Hukum', faculty_code: 'FH'},
  ].each do |study_program|
    sp = StudyProgram.new(
                      code: study_program[:code],
                      name: study_program[:name],
                      faculty_id: Faculty.find_by(code: study_program[:faculty_code]).id
                    )
    sp.save
  end

# PercentageAssessment seeds
  puts "Seed Percentage Assessment..."
  [ {name: "Kesetiaan", value: BigDecimal.new('10.0')},
    {name: "Prestasi Kerja", value: BigDecimal.new('20.0')},
    {name: "Tanggung Jawab", value: BigDecimal.new('20.0')},
    {name: "Ketaatan ", value: BigDecimal.new('10.0')},
    {name: "Kejujuran", value: BigDecimal.new('10.0')},
    {name: "Kerjasama", value: BigDecimal.new('15.0')},
    {name: "Prakarsa", value: BigDecimal.new('5.0')},
    {name: "Kepemimpinan", value: BigDecimal.new('10')}
  ].each do |percentage_assesment|
    pa =  PercentageAssessment.new(
            name: percentage_assesment[:name],
            value: percentage_assesment[:value]
         )
    pa.save
  end

# RankOfLecturer seeds
  puts "Seed Rank Of Lecturer..."
  [ {name: 'Juru Muda', symbol: 'I/a'},
    {name: 'Juru Muda Tingkat I', symbol: 'I/b'},
    {name: 'Juru  ', symbol: 'I/c'},
    {name: 'Juru Tingkat I', symbol: 'I/d'},
    {name: 'Pengatur Muda ', symbol: 'II/a'},
    {name: 'Pengatur Muda Tingkat I', symbol: 'II/b'},
    {name: 'Pengatur  ', symbol: 'II/c'},
    {name: 'Pengatur  Tingkat I', symbol: 'II/d'},
    {name: 'Penata Muda ', symbol: 'III/a'},
    {name: 'Penata Muda Tingkat I', symbol: 'III/b'},
    {name: 'Penata', symbol: 'III/c'},
    {name: 'Penata Tingkat I', symbol: 'III/d'},
    {name: 'Pembina', symbol: 'IV/a'},
    {name: 'Pembina Tingkat I', symbol: 'IV/b'},
    {name: 'Pembina Utama Muda', symbol: 'IV/c'},
    {name: 'Pembina Utama Madya', symbol: 'IV/d'},
    {name: 'Pembina Utama ', symbol: 'IV/e'}
  ].each do |rank_of_lecuterer|
    rof = RankOfLecturer.new(
      name: rank_of_lecuterer[:name],
      symbol: rank_of_lecuterer[:symbol],
      basic_salary: rand(500_000..10_000_000)
    )
    rof.save!
  end

# Lecturer seeds
  puts "Seed Lecturer..."
  (1..10).each do |index|
    Lecturer.new(
      registration_number_of_employees: rand(400000000..999999999).to_s,
      study_program_id: StudyProgram.pluck(:id).sample,
      rank_of_lecturer_id: RankOfLecturer.pluck(:id).sample,
      name: "Dosen-#{index}",
      place_of_birth: "Kuningan",
      date_of_birth: rand(DATE_OF_BIRTH_RANGE),
      gender: GENDER.sample,
      position: 'Pengajar',
      education: EDUCATION.sample,
      date_of_addmission: rand(DATE_OF_ADDMISSION_RANGE),
      marital_status: MARITAL_STATUS.sample
    ).save!
  end

# Assessor seeds
  puts "Seed Assessor..."
  (1..10).each do |index|
    Assessor.new(
      registration_number_of_employees: rand(400000000..999999999).to_s,
      study_program_id: StudyProgram.pluck(:id).sample,
      rank_of_lecturer_id: RankOfLecturer.pluck(:id).sample,
      name: "Penilai-#{index}",
      place_of_birth: "Kuningan",
      date_of_birth: rand(DATE_OF_BIRTH_RANGE),
      gender: GENDER.sample,
      position: 'Pengajar',
      education: EDUCATION.sample,
      date_of_addmission: rand(DATE_OF_ADDMISSION_RANGE),
      marital_status: MARITAL_STATUS.sample
    ).save!
  end

# Assessment Result seeds
  puts "Seed Assessment Result..."
  (1..5).each do |index_date_range|
    start_date = rand(Date.new(1990, 01, 01)..Date.new(2015, 01, 01))
    end_date = start_date + 1.week
    (1..5).each do |index_assessment_result|
      assessment_result = AssessmentResult.new(
        lecturer_id: Lecturer.pluck(:id).sample,
        assessor_id: Assessor.pluck(:id).sample,
        start_date: start_date,
        end_date: end_date
      )

      PercentageAssessment.all.each do |percentage_assessment|
        assessment_result.assessment_result_lines.build(
          percentage_assessment_id: percentage_assessment.id,
          value: rand(1..100)
        )
      end

      DocumentAction::AssessmentResult::Save.new(assessment_result: assessment_result).run
    end
  end

# List Of Ratings Execution Of Work
  puts "Seed List Of Ratings Execution Of Work..."
  AssessmentResult.all.each do |assessment_result|
    # list_of_ratings_execution_of_work
    ListOfRatingsExecutionOfWork.new(
      assessment_result_id: assessment_result.id,
      assessor_id: Assessor.pluck(:id).sample
    ).save
  end


# Preferment
  puts "Seed Preferment..."
  ListOfRatingsExecutionOfWork.all.each do |execution_of_work|
    preferment = Preferment.new(
      list_of_ratings_execution_of_work_id: execution_of_work.id,
      rank_of_lecturer_id: RankOfLecturer.pluck(:id).sample,
      decision_letter_number: SecureRandom.uuid,
      submissions_preferment_date: Time.now,
      preferment_date: Time.now + 1.week
    )
    Preferment::Save.new(preferment: preferment).run
  end

# Periodic Preferment
  puts 'Seed Periodic Preferment...'
  Preferment.all.each do |preferment|
    PeriodicPreferment.new(
      preferment_id: preferment.id,
      periodic_preferment_date: rand(Date.new(1990, 01, 01)..Date.new(2015, 01, 01)),
      periodic_preferment_number: SecureRandom.uuid
    ).save!
  end
