class ChangeColumnNullReviews < ActiveRecord::Migration
  def change
    change_column_null :reviews, :project_id, false
    change_column_null :reviews, :user_id, false
    change_column_null :reviews, :comment, false
    change_column_null :reviews, :star, false
  end
end
