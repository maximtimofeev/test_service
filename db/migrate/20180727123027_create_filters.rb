class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.string :city, default: ''
      t.string :topics, default: ''
      t.date :start_date, default: nil
      t.date :end_date, default: nil
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
