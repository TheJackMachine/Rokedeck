json.data do
  json.deck do
    json.uuid @deck.uuid
    json.name @deck.name
    json.focus @deck.focus
  end

  json.cards do
    json.array! @deck.cards do |card|
      json.uuid card.uid
      json.name card.name
      json.focus card.supertype
      json.types card.types
    end
  end

end

json.status 'success'
