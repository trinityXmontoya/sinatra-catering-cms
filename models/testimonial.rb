class Testimonial < ActiveRecord::Base
  validates :name, :event, :comment, presence: true
  after_create :capitalize

  def capitalize
    name.capitalize
    event.capitalize
    save
  end

  def toggle_approved
    update(approved: !approved)
  end

  def self.approved
    where(approved: true)
  end

end
