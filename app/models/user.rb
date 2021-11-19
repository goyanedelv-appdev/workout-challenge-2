class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:privileges, { :class_name => "Privilege", :foreign_key => "user_id", :dependent => :destroy })

  has_many(:participations, { :class_name => "Participation", :foreign_key => "user_id", :dependent => :destroy })

  has_many(:photos, { :class_name => "Photoworkout", :foreign_key => "user_id", :dependent => :destroy })
end
