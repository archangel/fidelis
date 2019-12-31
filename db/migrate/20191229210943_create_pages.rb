class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :permalink
      t.text :content, default: ""
      t.boolean :homepage, default: false
      t.integer :parent_id
      t.integer :design_id
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps
    end

    add_index :pages, :deleted_at
    add_index :pages, :design_id
    add_index :pages, :homepage
    add_index :pages, :parent_id
    add_index :pages, :permalink
    add_index :pages, :published_at
    add_index :pages, :slug
    add_index :pages, :title
  end
end
