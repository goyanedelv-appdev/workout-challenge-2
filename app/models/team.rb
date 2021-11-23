# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  team_name    :string
#  team_picture :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :integer
#
class Team < ApplicationRecord
  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })
  has_many(:participations, { :class_name => "Participation", :foreign_key => "team_id", :dependent => :destroy })

  has_many :user
  #has_many :photoworkouts
end
