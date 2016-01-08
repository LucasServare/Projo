# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(first_name: "Lucas", last_name: "Servare", email: "lucas.servare@gmail.com", password: "test")
project = user.projects.create(name: "Test Project", creator_id: user.id)
