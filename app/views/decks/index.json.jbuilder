json.data do
  json.array! @decks do |deck|
    json.uuid deck.uuid
    json.name deck.name
    json.focus deck.focus
  end
end

json.status 'success'
