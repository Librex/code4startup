class ChangeColumnNullProjects < ActiveRecord::Migration
  def change
    change_column_null :projects, :name, false
    change_column_null :projects, :content, false
    change_column_null :projects, :price, false
    change_column_null :projects, :image_file_name, false
    change_column_null :projects, :image_content_type, false
    change_column_null :projects, :image_file_size, false
    change_column_null :projects, :image_updated_at, false
    change_column_null :projects, :slug, false
  end
end