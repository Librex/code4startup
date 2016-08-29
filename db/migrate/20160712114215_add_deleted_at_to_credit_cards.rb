class AddDeletedAtToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :deleted_at, :datetime
    add_index :credit_cards, :deleted_at
  end
end
