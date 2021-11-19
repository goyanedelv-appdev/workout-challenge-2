# == Schema Information
#
# Table name: privileges
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :integer
#  user_id      :integer
#
class Privilege < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:challenge, { :required => true, :class_name => "Challenge", :foreign_key => "challenge_id" })
end
