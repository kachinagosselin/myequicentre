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
user2 = User.create! :first_name => 'Second', :last_name => 'User', :email => 'info@myequicentre.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.first_name
user3 = User.create! :first_name => 'Kachina', :last_name => 'Gosselin', :email => 'kachina@alum.mit.edu', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user3.first_name
user2.add_role :VIP
user3.add_role :admin

puts 'SETTING UP TEST HORSE OBJECTS'
horse21 = user2.horses.create! :name => 'His Horse', :breed => 'Arabian', :gender => 'Gelding', :dob => '2000-01-05', :height => 15.1, :text_description => 'A docile arab gelding for sale.', :price => 12000

horse22 = user2.horses.create! :name => 'Our Horse', :breed => 'Arabian', :gender => 'Stallion', :dob => '2003-02-15', :height => 15.3, :text_description => 'An energetic arabian stallion.', :price => 25000

horse23 = user2.horses.create! :name => 'My Horse', :breed => 'Warmblood', :gender => 'Mare', :dob => '2010-02-15', :height => 16.2, :text_description => 'A gentle warmblood mare for sale.', :price => 19000

puts 'New horse created: ' << horse21.text_description
puts 'New horse created: ' << horse22.text_description
puts 'New horse created: ' << horse23.text_description
horse31 = user3.horses.create! :name => 'First Horse', :breed => 'Arabian', :gender => 'Mare', :dob => '2000-01-05', :height => 15.1, :text_description => 'A lovely arab mare for sale.', :price => 12000
horse32 = user3.horses.create! :name => 'Second Horse', :breed => 'Andalusian', :gender => 'Stallion', :dob => '2003-02-15', :height => 15.3, :text_description => 'A spirited andalusian stallion.', :price => 25000
horse33 = user3.horses.create! :name => 'Third Horse', :breed => 'Warmblood', :gender => 'Gelding', :dob => '1988-08-24', :height => 16.2, :text_description => 'A gentle warmblood gelding for lease. Validates: Name Breed in list, Text description within range, with a character counter, Gender with dropdown menu, Limit age to acceptable range. Need to validate: Limit height to select values, though needs to store as int, Avatar* Add Horse location, inherits from owner Formatting of text', :price => 19000
puts 'New horse created: ' << horse31.text_description
puts 'New horse created: ' << horse32.text_description
puts 'New horse created: ' << horse33.text_description

