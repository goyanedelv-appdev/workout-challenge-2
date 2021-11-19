class Challenge < ApplicationRecord
  has_many(:participations, { :class_name => "Participation", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:photos, { :class_name => "Photoworkout", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:privileges, { :class_name => "Privilege", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:teams, { :class_name => "Team", :foreign_key => "challenge_id", :dependent => :destroy })
end
