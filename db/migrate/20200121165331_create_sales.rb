class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :total_amount,       null: false, default: 0
      t.integer :total_transactions, null: false, default: 0
      t.integer :average_amount,     null: false, default: 0
      t.integer :average_period,     null: false, default: 0

      t.timestamps
    end

    add_index :sales, :total_amount
    add_index :sales, :total_transactions
    add_index :sales, :average_amount
    add_index :sales, :average_period
  end
end
