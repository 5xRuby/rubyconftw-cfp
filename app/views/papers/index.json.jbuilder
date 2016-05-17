json.array!(@papers) do |paper|
  json.extract! paper, :id, :Title, :Abstract, :Outline, :file_name, :Status
  json.url paper_url(paper, format: :json)
end
