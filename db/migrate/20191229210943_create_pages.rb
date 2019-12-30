class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.string :permalink
      t.text :content
      t.boolean :homepage
      t.integer :parent_id
      t.integer :design_id
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps
    end
  end
end
