json.array!(@enq_answers) do |enq_answer|
  json.extract! enq_answer, :gender, :age, :time_req, :district, :source
  json.url enq_answer_url(enq_answer, format: :json)
end
