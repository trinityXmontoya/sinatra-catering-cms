class RemoveHiddenFromTestimonials < ActiveRecord::Migration
  def change
    remove_column :testimonials, :hidden, :boolean
  end
end
