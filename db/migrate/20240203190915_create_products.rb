class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :string do |t|
      t.string :name, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
