class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :content, default: ""
      t.integer :design_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :widgets, :deleted_at
    add_index :widgets, :design_id
    add_index :widgets, :name
    add_index :widgets, :slug
  end
end
