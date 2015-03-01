class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :slack_id
      t.string :name

      t.timestamps null: false
    end
  end
end
