class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :status, default: 0
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :payment_type, default: 0
      t.integer :total_payment
      t.integer :postage, default: 800
      t.timestamps
    end
  end
end
