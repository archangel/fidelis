class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :theme
      t.string :locale
      t.text :settings
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
