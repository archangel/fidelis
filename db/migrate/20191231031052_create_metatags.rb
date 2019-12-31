class CreateMetatags < ActiveRecord::Migration[6.0]
  def change
    create_table :metatags do |t|
      t.references :metatagable, polymorphic: true, null: false
      t.string :name, null: false
      t.string :content, default: ""

      t.timestamps
    end

    add_index :metatags, [:metatagable_id, :metatagable_type],
              name: "index_metatags_on_metatagable_id_and_type"
  end
end
