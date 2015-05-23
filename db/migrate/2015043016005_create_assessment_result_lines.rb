class CreateAssessmentResultLines < ActiveRecord::Migration
  def change
    create_table :assessment_result_lines do |t|
      t.integer :assessment_result_id, null: false
      t.integer :percentage_assessment_id, null: false
      t.decimal :value, precision: 20, scale: 4, default: 0, null: false

      t.timestamps
    end
  end
end
