namespace :db do
  desc "assigening tasks to random user..."
  task :relate_tasks => :environment do
    Task.all.each do |task|
      next unless task.user.nil?
      task.user = pick_random_user
      task.save
      puts "A Task #{task.title} is assigend to User #{task.user.name}"
    end
  end


  #-- this task requires password validation to be removed from model user  
  desc "assigening users to random organization..."
  task :relate_user => :environment do
    User.all.each do |user|
      next unless user.organization.nil?
      user.organization = pick_random_organization
      user.save
      puts "A User #{user.name} is assigend to Organization #{user.organization.name}"
      puts user.errors.first
    end
  end

  def pick_random_user
    User.find(:first, :order => 'RANDOM()')
  end

  def pick_random_organization
    Organization.find(:first, :order => 'RANDOM()')
  end
end