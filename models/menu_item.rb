class MenuItem < ActiveRecord::Base
  belongs_to :category
  validates :title, :description, :category, presence: true
end
