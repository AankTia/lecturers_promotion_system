class CreatePercentageAssessments < ActiveRecord::Migration
  def change
    #Bobot Nilai
    create_table :percentage_assessments do |t|
      t.string :code, null: false #Kode
      t.string :name, null: false #Nama
      t.text   :description #Deskripsi
      t.decimal :value, precision: 20, scale: 4, default: 0, null: false #Nilai

      t.timestamps
    end
  end
end
