class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id, null: false
      t.text :error_log
      t.integer :status, null: false
      t.string :webpay_recursion_id, null: false

      t.timestamps null: false
    end
  end
end
