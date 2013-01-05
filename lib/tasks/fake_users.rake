namespace :db do
  desc "Fill database with sample fake users"
  task fake_users: :environment do
    10.times do |n|
      name  = Faker::Name.name
      email = "dummy-#{n+1}-email@usersearch.com"
      password  = "password"
      user = User.new(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      user.organization = pick_random_organization
      user.save
    end
  end  

  def pick_random_organization
    Organization.find(:first, :order => 'RANDOM()')
  end
end