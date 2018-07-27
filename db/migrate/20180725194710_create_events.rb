class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :city

      t.timestamps
    end
    add_index :events, :name, unique: true
  end
end
