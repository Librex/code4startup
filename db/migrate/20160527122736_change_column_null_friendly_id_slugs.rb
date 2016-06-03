class ChangeColumnNullFriendlyIdSlugs < ActiveRecord::Migration
  def change
    change_column_null :friendly_id_slugs, :sluggable_type, false
    change_column_null :friendly_id_slugs, :scope, false
    change_column_null :friendly_id_slugs, :created_at, false
  end
end
