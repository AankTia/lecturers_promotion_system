class CreateStudyPrograms < ActiveRecord::Migration
  def change
    create_table :study_programs do |t|
      t.integer :faculty_id, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.string :education_level, null: false
      t.text   :description

      t.timestamps
    end
  end
end
