# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.create!(birth_date: Date.new(1999, 3, 3), color: "Red", name: "Turbi", sex: "M", description: "fast?" )
Cat.create!(birth_date: Date.new(2004, 3, 3), color: "Yellow", name: "Lupas", sex: "F", description: "sick?" )
Cat.create!(birth_date: Date.new(2014, 3, 3), color: "Green", name: "Gromet", sex: "M", description: "googy" )
