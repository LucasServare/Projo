# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create an initial user
user = User.create(first_name: "Lucas", last_name: "Servare", email: "lucas.servare@gmail.com", password: "test")
#Add another one
other_user = User.create(first_name: "Other", last_name: "Person", email: "other_email@fakeemail.com", password: "test")
#Create an initial project for our first user
project = user.projects.create(name: "Test Project", creator_id: user.id)
#Add another user to this project
project.users  << other_user
#Create a to do item for the initial user.
to_do_items = user.to_do_items.create(content: "Test Item")
