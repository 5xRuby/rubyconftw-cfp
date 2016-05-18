json.array!(@papers) do |paper|
  json.extract! paper, :id, :title, :abstract, :outline, :file_name, :status
  json.url paper_url(paper, format: :json)
end
