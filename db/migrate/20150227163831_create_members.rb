class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :slack_id
      t.string :name
      t.string :color

      t.timestamps null: false
    end
  end
end
