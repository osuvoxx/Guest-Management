class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  has_many :mettings
  accepts_nested_attributes_for :mettings 
end
