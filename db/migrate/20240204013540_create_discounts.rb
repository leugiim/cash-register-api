class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.references :product, foreign_key: true, type: :string, null: false
      t.string :strategy, null: false
      t.integer :quantity, null: false
      t.float :discount, null: false

      t.timestamps
    end

    add_column :tickets, :price, :float, null: false
    add_column :tickets, :discount, :float, null: false
    add_column :ticket_details, :price, :float, null: false
    add_column :ticket_details, :discount, :float, null: false
  end
end
