class CreateTopicables < ActiveRecord::Migration[5.2]
  def change
    create_table :topicables do |t|
      t.belongs_to :event, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
  end
end
