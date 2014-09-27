class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :name, null: :false
      t.string :event, null: :false
      t.string :comment, null: :false
    end
  end
end
