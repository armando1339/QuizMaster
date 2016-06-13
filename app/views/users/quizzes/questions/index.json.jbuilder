json.array!(@questions) do |question|
  json.extract! question, :id, :contect
  json.url question_url(question, format: :json)
end
