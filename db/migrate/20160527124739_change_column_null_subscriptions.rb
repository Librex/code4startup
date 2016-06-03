class ChangeColumnNullSubscriptions < ActiveRecord::Migration
  def change
    change_column_null :subscriptions, :project_id, false
    change_column_null :subscriptions, :user_id, false
  end
end
