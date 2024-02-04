class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.float :total_price, null: false

      t.timestamps
    end
  end
end
