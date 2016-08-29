class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|
      t.references :user, null: false
      t.references :plan, null: false

      t.timestamps null: false
    end
  end
end
