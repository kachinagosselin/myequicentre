# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'user' }, 
  { :name => 'VIP' }
], :without_protection => true)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name
user.add_role :admin
user2.add_role :VIP
user3 = User.create! :name => 'Kachina Gosselin', :email => 'kachina@alum.mit.edu', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user3.name

puts 'SETTING UP TEST HORSE OBJECTS'
horse1 = Horse.create! :name => 'First Horse', :breed => 'Arabian', :gender => 'Mare', :age => 12, :height => 15.1, :text_description => 'A lovely arab mare for sale', :price => 12000
horse2 = Horse.create! :name => 'Second Horse', :breed => 'Andalusian', :gender => 'Stallion', :age => 9, :height => 15.3, :text_description => 'A spirited andalusian stallion.', :price => 25000
horse3 = Horse.create! :name => 'Third Horse', :breed => 'Warmblood', :gender => 'Gelding', :age => 15, :height => 16.2, :text_description => 'A gentle warmblood gelding for lease.', :price => 19000
puts 'New horse created: ' << horse1.text_description
puts 'New horse created: ' << horse2.text_description
puts 'New horse created: ' << horse3.text_description

