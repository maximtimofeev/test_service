class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :body
      t.belongs_to :user, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
