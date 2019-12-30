class CreateDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :designs do |t|
      t.string :name
      t.text :content
      t.boolean :partial
      t.integer :parent_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
