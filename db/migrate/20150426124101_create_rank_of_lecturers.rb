class CreateRankOfLecturers < ActiveRecord::Migration
  #Pangkat / Golongan
  def change
    create_table :rank_of_lecturers do |t|
      t.string :code, null: false #Kode
      t.string :name, null: false #Nama
      t.text   :description #Deskripsi
      t.string :symbol, null: false #Symbol Pangkat
      t.decimal :basic_salary, precision: 20, scale: 4, default: 0, null: false #Nilai

      t.timestamps
    end
  end
end
