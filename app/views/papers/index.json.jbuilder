json.array!(@papers) do |paper|
  json.extract! paper, :id, :title, :abstract, :outline, :fileName, :status
  json.url paper_url(paper, format: :json)
end
