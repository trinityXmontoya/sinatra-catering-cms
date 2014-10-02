class SiteInfo < ActiveRecord::Base
  self.table_name = "site_info"
  validates :header_img,
             :header_description,
             :event_description,
             :home_description,
             :office_description,
             :about_img,
             :about_name,
             :about_description,
             :contact_img,
             :menu_bg_img, presence: true
end
