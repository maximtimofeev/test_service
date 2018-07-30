class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.with_options index: { unique: true } do
        string :name
        string :email
      end

      t.string :password
      t.timestamps
    end
  end
end
