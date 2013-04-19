class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :name
      	t.string :email
      	t.string :address
      	t.string :phone
      	t.integer :total
        t.integer :state

      t.timestamps
    end
  end
end
