class CreateListOfRatingsExecutionOfWorks < ActiveRecord::Migration
  def change
    # DP3
    create_table :list_of_ratings_execution_of_works do |t|
      t.string   :code, null: false # Kode
      t.integer  :assessor_id, null: false # Atasan Penilai
      t.integer  :assessment_result_id, null: false #penilaian
      t.string   :objection    #kebaratan
      t.date     :objection_date #tanggal keberatan
      t.string   :response     #tanggapan
      t.date     :response_date  #waktu keberatan
      t.string   :decision     #keputusan
      t.date     :decision_date  #waktu keputusan
      t.string   :state, null: false

      t.timestamps
    end
  end
end
