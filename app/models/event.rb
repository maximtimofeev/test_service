class Event < ApplicationRecord
  has_many :topicables
  has_many :topics, through: :topicables

  has_many :comments
  has_many :commentators, through: :comments, source: :user

  validates :name, :description, presence: true
  validates :start_date, :end_date, presence: true

  def all_topics
    self.topics.map(&:name).join(', ')
  end

  def all_topics=(names)
    self.topics = names.split(',').map do |name|
      Topic.where(name: name.strip).first_or_create!
    end
  end
end
