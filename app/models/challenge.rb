# == Schema Information
#
# Table name: challenges
#
#  id                    :integer          not null, primary key
#  challenge_handle      :string
#  challenge_image       :string
#  challenge_name        :string
#  challenge_type        :integer
#  ending_time           :string
#  new_user_policy       :integer
#  number_of_teams       :integer
#  penalty_policy        :integer
#  prize_policy          :text
#  removal_policy        :integer
#  starting_time         :datetime
#  workout_criteria      :integer
#  workout_perday_policy :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Challenge < ApplicationRecord
  has_many(:participations, { :class_name => "Participation", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:photos, { :class_name => "Photoworkout", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:privileges, { :class_name => "Privilege", :foreign_key => "challenge_id", :dependent => :destroy })
  has_many(:teams, { :class_name => "Team", :foreign_key => "challenge_id", :dependent => :destroy })

  mount_uploader :challenge_image, ChallengeAvatarUploader

end
