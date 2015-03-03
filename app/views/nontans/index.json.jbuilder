json.array!(@nontans) do |nontan|
  json.extract! nontan, :id, :practice_pln_id, :part_id, :user_name, :subs_name, :reason
  json.url nontan_url(nontan, format: :json)
end
