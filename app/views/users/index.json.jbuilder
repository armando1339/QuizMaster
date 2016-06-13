json.array!(@users) do |user|
  json.extract! user, :id, :type
  json.url user_url(user, format: :json)
end
