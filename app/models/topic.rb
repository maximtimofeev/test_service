class Topic < ApplicationRecord
  has_many :topicables
  has_many :events, through: :topicables
end
