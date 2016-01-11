json.array!(@slips) do |slip|
  json.extract! slip, :id, :user_id, :amount, :slip_dtl_id
  json.url slip_url(slip, format: :json)
end
