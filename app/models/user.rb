# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  bio             :text
#  email           :string
#  is_premium      :boolean
#  password_digest :string
#  profile_picture :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:privileges, { :class_name => "Privilege", :foreign_key => "user_id", :dependent => :destroy })

  has_many(:participations, { :class_name => "Participation", :foreign_key => "user_id", :dependent => :destroy })

  has_many(:photos, { :class_name => "Photoworkout", :foreign_key => "user_id", :dependent => :destroy })

  mount_uploader :profile_picture, UserAvatarUploader

end
