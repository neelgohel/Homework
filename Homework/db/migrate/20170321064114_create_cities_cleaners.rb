class CreateCitiesCleaners < ActiveRecord::Migration[5.0]
  def change
    create_table :cities_cleaners do |t|
      t.references :city, foreign_key: true
      t.references :cleaner, foreign_key: true

      t.timestamps
    end
  end
end
