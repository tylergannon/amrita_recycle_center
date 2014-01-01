# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
Category.create([
  {name: "Hard Items"},
  {name: "Soft Plastic"},
  {name: "Paper"},
  {name: "Sanitary"}
])

Location.delete_all
Location.create([
  {name: "Waste Station"},
  {name: "Beach"},
  {name: "Unknown"},
  {name: "Pre-sort"},
  {name: "Paper Table"},
  {name: "Hard Items Table"},
  {name: "Storage"},
  {name: "Downstream"}
])

Account.delete_all
Location.all.each do |location|
  Category.all.each do |category|
    Account.create location: location, category: category
  end
end

Container.delete_all
Container.create([
  {name: Container::NO_CONTAINER_NAME, capacity: 0, empty_weight: 0},
  {name: '120L Red Bin', capacity: 120, empty_weight: 3.5},
  {name: '120L Blue Bin', capacity: 120, empty_weight: 3.5},
  {name: '120L Orange Bin', capacity: 120, empty_weight: 3.5},
  {name: '100L Pink Bin', capacity: 100, empty_weight: 3.5},
  {name: '60L Beige Bin', capacity: 60, empty_weight: 2}
])
