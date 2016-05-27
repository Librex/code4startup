class ChangeColumnNull < ActiveRecord::Migration
  def change
    change_column_null :active_admin_comments, :namespace, false
    change_column_null :active_admin_comments, :body, false
    change_column_null :active_admin_comments, :author_id, false
    change_column_null :active_admin_comments, :author_type, false
    change_column_null :active_admin_comments, :created_at, false
    change_column_null :active_admin_comments, :updated_at, false
  end
end
