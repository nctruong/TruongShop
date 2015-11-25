json.array!(@parsers) do |parser|
  json.extract! parser, :id
  json.url parser_url(parser, format: :json)
end
