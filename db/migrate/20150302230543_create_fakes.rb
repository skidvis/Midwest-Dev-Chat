class CreateFakes < ActiveRecord::Migration
  def change
    create_table :fakes do |t|
      t.string :fake_name
      t.string :real_name

      t.timestamps null: false
    end
  end
end
