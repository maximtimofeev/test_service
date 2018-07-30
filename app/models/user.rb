class User < ApplicationRecord
  has_one :filter
  has_many :comments
  has_many :commented_events, through: :comments, source: :event
  has_many :notifications

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :password, :email, presence: true
  validates :name, length: { minimum: 3, maximum: 16 }
  validates :name, uniqueness: true
end
