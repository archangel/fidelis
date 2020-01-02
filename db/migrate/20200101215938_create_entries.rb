class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :collection_id, null: false
      t.text :value
      t.integer :position
      t.datetime :published_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :entries, :available_at
    add_index :entries, :collection_id
    add_index :entries, :deleted_at
    add_index :entries, :position
  end
end
