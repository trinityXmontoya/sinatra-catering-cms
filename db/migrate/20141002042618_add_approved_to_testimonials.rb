class AddApprovedToTestimonials < ActiveRecord::Migration
  def change
    add_column :testimonials, :approved, :boolean, null: :false, default: :false
  end
end
