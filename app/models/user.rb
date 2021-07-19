class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  validates :phone, uniqueness: true

  has_many :mettings ,dependent: :destroy
  accepts_nested_attributes_for :mettings 
end
