class CreateAssessmentRanges < ActiveRecord::Migration
  def change
    create_table :assessment_ranges do |t|
      t.string   :code,       null: false
      t.date     :start_date, null: false
      t.date     :end_date,   null: false
      t.text     :description
      t.string   :state,      null: false

      t.timestamps
    end
  end
end
