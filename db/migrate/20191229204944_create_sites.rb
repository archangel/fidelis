class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name, null: false, default: "Archangel"
      t.string :theme
      t.string :locale, null: false, default: "en"
      t.text :settings
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :sites, :deleted_at
    add_index :sites, :name
  end
end
