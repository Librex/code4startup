class CreatePlanUsers < ActiveRecord::Migration
  def change
    create_table :plan_users do |t|
      t.references :user
      t.references :plan
      t.integer :count

      t.timestamps null: false
    end
  end
end
