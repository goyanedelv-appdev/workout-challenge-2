# == Schema Information
#
# Table name: photoworkouts
#
#  id            :integer          not null, primary key
#  calories      :integer
#  caption       :text
#  likes_count   :integer
#  main_exercise :string
#  photo_locator :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  challenge_id  :integer
#  user_id       :integer
#
class Photoworkout < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })

  mount_uploader :photo_locator, WorkoutPictureUploader

  # has_many :users
  # has_many :teams
  #belongs_to(:team, { :required => true, :class_name => "Team", :foreign_key => "user_id" })
end
