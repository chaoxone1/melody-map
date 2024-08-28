require 'faker'

# Clear existing data to avoid duplicates
Bookmark.destroy_all
Follower.destroy_all
Event.destroy_all
User.destroy_all

# Create Users
users = []
20.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.username,
    password: "password",  # Assuming you're using Devise
    password_confirmation: "password",  # Assuming you're using Devise
    address: Faker::Address.full_address,
    categories: Faker::Lorem.words(number: 3).join(", "),
    radius: rand(5..50),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

# Create Events - Each event is associated with a single user
events = []
20.times do
  events << Event.create!(
    name: Faker::Music::RockBand.name + " Concert",
    date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    location: Faker::Address.full_address,
    user: users.sample,  # Each event is created by a single random user
    category: Faker::Music.genre,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

# Create Followers
20.times do
  user = users.sample
  following = users.sample

  # Ensure a user cannot follow themselves
  while user == following
    following = users.sample
  end

  Follower.create!(
    user: user,
    following: following
  )
end

# Create Bookmarks
20.times do
  Bookmark.create!(
    user: users.sample,
    event: events.sample
  )
end

puts "Seed data created successfully!"
