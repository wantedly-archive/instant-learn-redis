# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

1000.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, avatar_url: Faker::Avatar.image)
end

first_user_id = USer.first.id
last_user_id = User.last.id
user_id_range = first_user_id..last_user_id
user_ids = user_id_range.to_a

user_id_range.each do |user_id|
  user_ids.sample(500) do |friend_id|
    if user_id != friend_id
      Relation.create!(user_id: user_id, friend_id: friend_id)
      Relation.create!(user_id: friend_id, friend_id: user_id)
    end
  end
end
