class ChangeColumnNullBlogs < ActiveRecord::Migration
  def change
    change_column_null :blogs, :title, false
    change_column_null :blogs, :content, false
  end
end
