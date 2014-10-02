class CreateSiteInfo < ActiveRecord::Migration
  def change
    create_table :site_info do |t|
      t.string :header_img, null: :false
      t.string :header_description, null: :false
      t.string :services_byline
      t.text :event_description, null: :false
      t.text :home_description, null: :false
      t.text :office_description, null: :false
      t.string :about_img, null: :false
      t.string :about_name, null: :false
      t.string :about_byline, null: :false
      t.text :about_description, null: :false
      t.string :contact_img, null: :false
      t.string :contact_byline
      t.string :menu_bg_img, null: :false
    end
  end
end
