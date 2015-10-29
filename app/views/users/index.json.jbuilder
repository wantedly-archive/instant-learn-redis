json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :avatar_url
  json.url user_url(user, format: :json)
end
