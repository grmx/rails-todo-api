class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :projects

  validates :email, uniqueness: { case_sensitive: false }
end
