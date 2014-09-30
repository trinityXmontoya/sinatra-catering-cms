Category.create!(id: 1,name: "Breakfast")
Category.create!(id: 2,name: "Lunch")
Category.create!(id:3,name: "Dinner")

Testimonial.create!(name: "Dan",
                    event: "Dinner Party",
                    comment: "Loved it, most delicious meal I've ever had and my guests loved it! Hannah's dad rocks.")
Testimonial.create!(name: "Twitter",
                    event: "Office party",
                    comment: "Nothing but good things to say, professional *and* fun, exquisite meal.")

Testimonial.create!(name: "Hannah",
                    event: "Birthday party",
                    comment: "He's my dad but, he's really the best there is! Recommend him 100%")

# MenuItem.create!(title: "dogfish",
#                  description: "loveliest ingredients",
#                  category_id: 1)
# MenuItem.create!(title: "fishdog",
#                  description: "very good",
#                  category_id: 2)
# MenuItem.create!(title: "fishy dog",
#                  description: "as described",
#                  category_id: 3)
