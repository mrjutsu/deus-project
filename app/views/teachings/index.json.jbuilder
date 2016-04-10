json.array!(@teachings) do |teaching|
  json.extract! teaching, :id, :teaching_name, :summary, :body, :user_id
  json.url teaching_url(teaching, format: :json)
end
