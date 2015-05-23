class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|      
      t.string :code, null: false
      t.string :name, null: false
      t.text   :description

      t.timestamps
    end
  end
end
