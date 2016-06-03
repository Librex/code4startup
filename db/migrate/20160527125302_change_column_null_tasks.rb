class ChangeColumnNullTasks < ActiveRecord::Migration
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :note, false
    change_column_null :tasks, :video, false
    change_column_null :tasks, :tag, false
    change_column_null :tasks, :project_id, false
    change_column_null :tasks, :slug, false
  end
end
