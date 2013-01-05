# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Seeding Organization Table with Dummy Data..."

FactoryGirl.define do
  factory :organization do
    name     Forgery(:name).company_name
    email    Forgery(:email).address
    address1 Forgery(:address).street_address
    address2 Forgery(:address).street_name
    phone    Forgery(:address).phone
    city     Forgery(:address).city
    country  Forgery(:address).country
    zip      Forgery(:address).zip
  end
end

10.times do |n|
	puts "creating organization recorn #{n}"
	FactoryGirl.create(:organization)
end