class CreatePreferments < ActiveRecord::Migration
  # Kenaikan Pangkat
  def change
    create_table :preferments do |t|
      t.string  :code, null: false
      t.integer :list_of_ratings_execution_of_work_id, null: false # Id DP3 (Foreign Key)
      t.integer :rank_of_lecturer_id, null: false #Pangkat baru
      t.integer :current_rank_of_lecturer_id, null: false #Pangkat sekarang
      t.integer :year_work_period #jumlah tahun masa kerja
      t.integer :month_work_period #jumlah bulan masa kerja
      t.integer :day_work_period #jumlah hari masa kerja
      t.string  :decision_letter_number, null: false #No SK pangkat
      t.date    :submissions_preferment_date, null: false #Tgl ajuan Kenaikan pangkat
      t.date    :preferment_date, null: false #Tgl Kenaikan pangkat

      t.timestamps
    end

    # add_index :preferments, :code, unique: true
    add_index :preferments, :list_of_ratings_execution_of_work_id
    add_index :preferments, :rank_of_lecturer_id
    add_index :preferments, :current_rank_of_lecturer_id
  end
end
