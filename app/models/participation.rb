class Participation < ApplicationRecord

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })

  belongs_to(:team, { :required => true, :class_name => "Team", :foreign_key => "team_id" })
  
end
