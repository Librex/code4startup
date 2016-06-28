class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :amount
      t.boolean :complete_flg
      t.boolean :student_flg
      t.timestamps null: false
    end
  end
end
