class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :content
      t.integer :free_flg, default: 1

      t.timestamps null: false
    end
  end
end
