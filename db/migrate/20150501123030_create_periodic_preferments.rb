class CreatePeriodicPreferments < ActiveRecord::Migration
  # Kenaikan Pangkat Berkala
  def change
    create_table :periodic_preferments do |t|
      t.string  :code, null: false
      t.integer :preferment_id, null: false # Id DP3 (Foreign Key)
      t.date    :periodic_preferment_date, null: false #Tgl kenaikan berkala
      t.string  :periodic_preferment_number, null: false #No surat berkala

      t.timestamps
    end
  end
end
