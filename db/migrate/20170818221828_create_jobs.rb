class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :user, index: true
      t.string :title, null: false
      t.string :description
      t.string :company, null: false
      t.string :url, null: false
      t.string :remote_options
      t.datetime :post_date

      t.timestamps null: false
    end
    add_foreign_key :jobs, :users
  end
end
