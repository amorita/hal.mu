json.array!(@poster_candidates) do |poster_candidate|
  json.extract! poster_candidate, :id, :selection, :mail, :user_id
  json.url poster_candidate_url(poster_candidate, format: :json)
end
