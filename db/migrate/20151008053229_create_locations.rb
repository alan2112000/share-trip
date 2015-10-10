class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.float :longtitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end
