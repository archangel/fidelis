class CreateDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :designs do |t|
      t.string :name, null: false
      t.text :content, default: ""
      t.boolean :partial, default: false
      t.integer :parent_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :designs, :deleted_at
    add_index :designs, :parent_id
  end
end
