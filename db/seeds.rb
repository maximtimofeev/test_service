Topicable.destroy_all
Topic.destroy_all
Event.destroy_all

hash_events = 10.times.map do
  {
    name: Faker::Fallout.character,
    description: Faker::Fallout.quote,
    city: Faker::Fallout.location,
    start_date: Faker::Date.backward(10),
    end_date: Faker::Date.forward(10),
    all_topics: Faker::Dog.name
  }
end

Event.create! hash_events
