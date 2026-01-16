class AddDistAndOwnerDistToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :dist_id, :integer, null: false
    add_column :users, :ownerdist_id, :integer, null: false
  end
end
