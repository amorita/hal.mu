json.array!(@practice_plns) do |practice_pln|
  json.extract! practice_pln, 
  json.url practice_pln_url(practice_pln, format: :json)
end
