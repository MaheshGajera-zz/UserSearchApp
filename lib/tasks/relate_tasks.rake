
  desc "update un assigend tasks to random user"
  task :relate_tasks => :environment do
    Task.all.each do |task|
      next unless task.user.nil?
      user = pick_random_user
      task.user = user
      task.save
      puts "Selected Task: #{task.title}"
      puts "Assigend to User: #{user.name}"
    end
  end
  
  def pick_random_user
    User.find(:first, :order => 'RANDOM()')
  end