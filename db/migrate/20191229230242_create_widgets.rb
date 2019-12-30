class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :slug
      t.text :content
      t.integer :design_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
