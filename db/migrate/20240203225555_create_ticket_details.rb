class CreateTicketDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_details do |t|
      t.references :ticket, foreign_key: true
      t.references :product, foreign_key: true, type: :string
      t.string :product_name, null: false
      t.integer :quantity, null: false
      t.float :price_per_unit, null: false
      t.float :total_price, null: false

      t.timestamps
    end
  end
end
