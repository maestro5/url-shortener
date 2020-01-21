class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :sale_id
      t.string  :email,      null: false
      t.string  :first_name, null: false
      t.string  :last_name,  null: false
      t.integer :amount,     null: false

      t.timestamps
    end

    add_index :transactions, :sale_id
    add_index :transactions, :email
    add_index :transactions, :first_name
    add_index :transactions, :amount
    add_index :transactions, :created_at
  end
end
