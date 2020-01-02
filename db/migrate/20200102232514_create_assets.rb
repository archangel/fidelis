class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :name, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :assets, :deleted_at
    add_index :assets, :name, unique: true
  end
end
