class AddSlugToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :slug, :string, null: false
  end
end
