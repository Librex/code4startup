class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id, null: false
      t.string :purchase_date
      t.boolean :availability
      t.integer :continuation
      t.date :expire_date
      t.string :webpay_recursion_id, null: false

      t.timestamps null: false
    end
  end
end
