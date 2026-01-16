class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.string :title
      t.integer :value
      t.string :valuetxt
      t.text :comment
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :optionid
    end
  end
end
