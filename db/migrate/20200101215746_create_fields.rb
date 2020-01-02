class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.integer :collection_id, null: false
      t.string :label
      t.string :slug
      t.string :default_value
      t.string :classification
      t.boolean :required
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :fields, :classification
    add_index :fields, :collection_id
    add_index :fields, :deleted_at
    add_index :fields, :label
    add_index :fields, :required
    add_index :fields, :slug
  end
end
