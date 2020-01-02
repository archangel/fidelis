class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :collections, :deleted_at
    add_index :collections, :name
    add_index :collections, :slug
  end
end
