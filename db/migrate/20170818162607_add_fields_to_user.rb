class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string, null: false
    add_column :users, :slackhandle, :string
    add_column :users, :career_status, :string, default: 'Unavailable'
    add_column :users, :location, :string
    add_column :users, :max_distance, :string
    add_column :users, :will_relocate, :boolean
    add_column :users, :will_remote, :boolean
    add_column :users, :preferred_languages, :string
    add_column :users, :resume, :string
    add_column :users, :linkedin, :string
    add_column :users, :github, :string
  end
end
