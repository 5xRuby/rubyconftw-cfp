json.array!(@papers) do |paper|
  json.extract! paper, :id, :Title, :Abstract, :Outline, :FileName, :Status
  json.url paper_url(paper, format: :json)
end
