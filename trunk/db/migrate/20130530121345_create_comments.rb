class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string   :product_id
      t.string   :user_id
      t.string   :content
      t.timestamps
    end
  end
end
