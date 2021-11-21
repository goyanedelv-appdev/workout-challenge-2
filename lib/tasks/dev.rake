# desc "Hydrate the database with some sample data to look at so that developing is easier"
# task({ :sample_data => :environment}) do
# end

desc "Fill the database tables with some sample data"
task({ :sample_data_users => :environment}) do
  require 'faker'
  
  time = Time.now

  50.times do 
    user = User.new

    user.email = Faker::Internet.email
    user.password_digest = "password"
    user.is_premium = false
    user.profile_picture = "https://loremflickr.com/100/120/fitness"
    user.bio = Faker::GreekPhilosophers.quote
    user.username = Faker::Name.first_name 
    user.created_at = time
    user.updated_at = time

    user.save
  end
end

desc "Create challenges"
task({ :sample_data_challenges => :environment}) do
  require 'faker'
  time = Time.now

  challenge = Challenge.new
  challenge.starting_time = "2021-11-22 00:00:00 UTC"
  challenge.ending_time = "2021-12-26 23:59:59 UTC"
  challenge.challenge_name = "My winter challenge"
  challenge.challenge_image = "https://loremflickr.com/300/300/barbecue"
  challenge.removal_policy = 1
  challenge.new_user_policy = 1
  challenge.penalty_policy = 1
  challenge.workout_perday_policy = 1
  challenge.workout_criteria = 1
  challenge.prize_policy = "Losers pay a bbq!"
  challenge.challenge_handle = "my_challenge"
  challenge.number_of_teams = 2
  challenge.challenge_type = 1
  challenge.created_at = time
  challenge.updated_at = time

  challenge.save

end

desc "Anhilitation of users"
task({ :anhilate_users => :environment}) do
  User.destroy_all
  p "I'm stronger than Thanos"
end

# desc "Participations"
# task({ :sample_data_participations => :environment}) do

#   time = Time.now

#   part = Participation.new
#   part.user_id = 104
#   part.challenge_id = 1
#   part.team_id = 1
#   part.created_at = time
#   part.updated_at = time

#   part.save

# end

desc "Photoworkouts"
task({ :sample_data_photoworkouts => :environment}) do
  require 'faker'
  
  200.times do 
    phwt =  Photoworkout.new
    
    phwt.calories = rand(250..360)
    phwt.caption = Faker::Hipster.sentence
    phwt.likes_count = 0
    phwt.main_exercise =  Faker::Food.fruits
    phwt.photo_locator = "https://loremflickr.com/500/300/fitness"
    phwt.challenge_id = 1
    phwt.user_id = [101,102,103,104,105,106,107,108,109,110].sample

    phwt.save
  end
    
end

desc "Create challenges 2"
task({ :sample_data_challenges_2 => :environment}) do
  require 'faker'
  time = Time.now

  challenge = Challenge.new
  challenge.starting_time = "2021-11-25 00:00:00 UTC"
  challenge.ending_time = "2021-12-31 23:59:59 UTC"
  challenge.challenge_name = "Workout to beers"
  challenge.challenge_image = "https://loremflickr.com/300/300/barbecue"
  challenge.removal_policy = 1
  challenge.new_user_policy = 1
  challenge.penalty_policy = 1
  challenge.workout_perday_policy = 1
  challenge.workout_criteria = 1
  challenge.prize_policy = "Losers pay a round of beers!"
  challenge.challenge_handle = "beers_or_die"
  challenge.number_of_teams = 2
  challenge.challenge_type = 1
  challenge.created_at = time
  challenge.updated_at = time

  challenge.save

end

desc "Create challenges 2"
task({ :re_do_images => :environment}) do


end