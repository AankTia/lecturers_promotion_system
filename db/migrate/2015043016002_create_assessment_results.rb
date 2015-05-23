class CreateAssessmentResults < ActiveRecord::Migration
  def change
    # Penilaian Migration
    create_table :assessment_results do |t|
      t.string   :code, null: false
      t.integer  :lecturer_id, null: false
      t.integer  :assessor_id, null: false # nama penilai
      t.date     :start_date, null: false
      t.date     :end_date, null: false
      t.decimal :value, precision: 20, scale: 4, default: 0, null: false

      t.timestamps
    end

    add_index :assessment_results, :code, unique: true
    add_index :assessment_results, :lecturer_id
    add_index :assessment_results, :assessor_id


    # add_foreign_key :assessment_results, :lecturers
    # add_foreign_key :assessment_results, :assessors
  end
end
