class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :imageurl
      t.integer :price
      t.string :currency
      t.text :description

      t.timestamps
    end
  end
end
