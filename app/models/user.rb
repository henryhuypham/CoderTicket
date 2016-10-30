class User < ActiveRecord::Base
  has_many :events, foreign_key: 'creator_id'

  validates_uniqueness_of :email

  has_secure_password
end
