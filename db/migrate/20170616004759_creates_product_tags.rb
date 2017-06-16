class CreatesProductTags < ActiveRecord::Migration[5.1]
  def change
    create_table :product_tags do |t|
      t.string :name
      t.references :product, foreign_key: true
      t.index [:name, :product_id], unique: true

      t.timestamps
    end
  end
end
