class CreateFaces < ActiveRecord::Migration[8.0]
  def change
    create_table :faces, primary_key: :fid, id: :bigint, force: :cascade do |t|
      t.string :title
      t.string :shorttitle
      t.string :address
      t.boolean :active
      t.text :description
      t.string :rut
      t.integer :ftype
      t.integer :dist_id, null: false
      t.integer :ownerdist_id, null: false

      t.timestamps null: false
    end
  end
end
