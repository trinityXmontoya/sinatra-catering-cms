class Testimonial < ActiveRecord::Base
  validates :name, :event, :comment, presence: true
end
