class ChangeColumnNullAdminUsers < ActiveRecord::Migration
  def change
    change_column_null :admin_users, :reset_password_token, false
    change_column_null :admin_users, :reset_password_sent_at, false
    change_column_null :admin_users, :remember_created_at, false
    change_column_null :admin_users, :current_sign_in_at, false
    change_column_null :admin_users, :last_sign_in_at, false
    change_column_null :admin_users, :current_sign_in_ip, false
    change_column_null :admin_users, :last_sign_in_ip, false
  end
end
