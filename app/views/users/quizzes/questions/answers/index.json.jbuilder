json.array!(@answers) do |answer|
  json.extract! answer, :id, :type, :contect
  json.url answer_url(answer, format: :json)
end
