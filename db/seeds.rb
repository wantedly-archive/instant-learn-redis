# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

users = []
1000.times do
  users << User.new(name: Faker::Name.name, email: Faker::Internet.email, avatar_url: Faker::Avatar.image)
end
User.import(users)

first_user_id = User.first.id
last_user_id = User.last.id
user_ids = (first_user_id..last_user_id).to_a

user_ids.each_slice(100) do |sliced|
  relations = []
  sliced.each do |user_id|
    user_ids.sample(100).each do |friend_id|
      if user_id != friend_id
        relations << Relation.new(user_id: user_id, friend_id: friend_id)
        relations << Relation.new(user_id: friend_id, friend_id: user_id)
      end
    end
  end
  Relation.import(relations)
end
