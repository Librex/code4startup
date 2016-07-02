class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :date, null: false
      t.string :year, null: false
      t.string :cc_type, null: false
      t.integer :last_digits, null: false
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :token, null: false
      t.string :webpay_customer_id, null: false
      t.timestamps null: false
    end
  end
end
