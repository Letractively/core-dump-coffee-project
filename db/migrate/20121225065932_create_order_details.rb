class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
    	t.integer :order_id
      	t.integer :product_id
      	t.integer :qrt

      t.timestamps
    end
  end
end
