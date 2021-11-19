class Team < ApplicationRecord
  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })
  has_many(:participations, { :class_name => "Participation", :foreign_key => "team_id", :dependent => :destroy })
end
