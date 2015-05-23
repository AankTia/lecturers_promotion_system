class CreateAssessors < ActiveRecord::Migration
  def change
    create_table :assessors do |t|
      t.string  :registration_number_of_employees, null: false #NIK
      t.integer :study_program_id, null: false #Program Studi
      t.integer :rank_of_lecturer_id, null: false #Pangkat/Golonngan
      t.string  :name, null: false #Nama
      t.string  :place_of_birth, null: false #Tempat lahir
      t.date    :date_of_birth, null: false #Tanggal Lahir
      t.string  :gender, null: false #Jenis Kelamin
      t.string  :marital_status, null: false #Status
      t.string  :address_line1 #Alamat 1
      t.string  :address_line2 #Alamat 2
      t.string  :address_line3 #Alamat 3
      t.string  :address_line4 #Alamat 4
      t.string  :position, null: false #Jabatan
      t.string  :education, null: false #Pensisikan
      t.date    :date_of_addmission, null: false #Tanggal Masuk
      t.string  :contact_number #Kontak

      t.timestamps
    end
  end
end
