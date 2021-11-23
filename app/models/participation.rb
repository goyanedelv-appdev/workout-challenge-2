# == Schema Information
#
# Table name: participations
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :integer
#  team_id      :integer
#  user_id      :integer
#
class Participation < ApplicationRecord

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })

  belongs_to(:team, { :required => true, :class_name => "Team", :foreign_key => "team_id" })
  
  # has_many(:photoworkout, { :through => :user, :source => :photoworkouts })
end
