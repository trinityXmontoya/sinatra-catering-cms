class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :title, null: :false
      t.text :description, null: :false
      t.references :category, null: :false
    end
  end
end
