json.array!(@reports) do |report|
  json.extract! report, :id, :title, :description, :body, :location
  json.url report_url(report, format: :json)
end
