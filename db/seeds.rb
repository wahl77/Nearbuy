# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Country.destroy_all
Category.destroy_all

%w[Switzerland USA].each do |x|
  Country.create!(name: x)
end

address = Address.create!(number_and_street: "414 Brannan Street", city: "San Francisco", zip_code: "94107", state: "CA", country: Country.find_by_name("Usa"))

%w( General Rentals Neighborliness Travel Education Pets Events Jobs Recommendations Restaurant Bar ).each do |x| 
  Category.create(name: x)
end


# Data 
a = User.create!(email: "a@a.com", password: "a")

100.times do |i|
  User.first.items.create!(address: address, name: "Item#{i}", categories: [Category.first])
end
