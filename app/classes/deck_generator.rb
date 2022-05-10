require 'pokemon_tcg_sdk'
require 'json'

class DeckGenerator

  @@valid_types = []
  @@type_max_range = 16
  @@type_min_range = 12
  @@energy_number = 10
  @@deck_size = 60

  def self.create(type = nil)
    self.init_valid_types
    type = self.check_type(type)
    cards = self.generate_deck(type)
    # save cards in database
    uid_list = self.save_cards(cards)
  end

  #------------------------
  # Protected
  #------------------------

  #protected

  def self.check_type(type)
    return self.random_type if type.nil?
  end

  #
  # Generate a deck
  #
  def self.generate_deck(type)

    self.validate_type(type)
    # 1 - Add 12 - 16 pokemon card of specific type
    cards = self.add_pokemon_cards(type, self.number_of_pokemon_cards)
    puts "add pokemon card done"

    # 2 - Add 10 energy cards
    # cards = cards.concat(cards)
    cards.concat(self.add_energy_cards(type, self.remainder_cards_number(cards)))
    # puts "add pokemon card done"

    # 3 - Add training card
    cards.concat(self.add_trainer_cards(self.remainder_cards_number(cards)))
    puts "add Energy card done"
    return cards
  end

  #
  # Add 12 - 16 pokemon card of specific type
  #
  def self.add_pokemon_cards(type, number)
    pokemon_cards = self.fetch_pokemon_type(type)
    puts "end of fetch"
    puts type + "end of fetch" + number.to_s

    cards = []

    (0...number).each { |_|
      cards << pokemon_cards[rand(0...pokemon_cards.length)]
    }
    return cards
  end

  #
  # Add 10 energy cards
  #
  def self.add_energy_cards(type, number)
    energy_cards = self.fetch_energy_type(type)
    cards = []
    puts ' Adding some Energy Cards ' + number.to_s
    (0...number).each { |_|
      cards << self.random_card(energy_cards)
    }
    return cards
  end

  #
  # Add training card
  #
  def self.add_trainer_cards(number)
    trainer_cards = self.fetch_training_card
    cards = []
    occurrences = {}

    (0...number).each { |_|
      selected_card = self.random_card(trainer_cards)

      if !occurrences.key?(selected_card.name)
        occurrences[selected_card.name] = 1
      else
        occurrences[selected_card.name] += 1
      end

      cards << selected_card
    }

    return cards
  end

  def self.number_of_pokemon_cards
    return rand(@@type_min_range..@@type_max_range)
  end

  # init types with pokemon API
  def self.init_valid_types
    @@valid_types = Pokemon::Type.all if @@valid_types.empty?
  end

  # validate the type
  def self.validate_type(type)
    unless @@valid_types.include? type
      raise "Wrong type"
    end
  end

  #------------------------
  # Fetching
  #------------------------

  # get pokemon by type
  def self.fetch_pokemon_type(type)
    puts "Start get Pokemon type " + type
    return Pokemon::Card.where(q: 'supertype:Pokémon types:' + type)
  end

  # get Energy card by type via API
  def self.fetch_energy_type(type)
    puts "Start get Energy " + type
    return Pokemon::Card.where(q: 'supertype:Energy name:' + type)
  end

  # get Trainer card via API
  def self.fetch_training_card
    puts "Start get Trainer"
    return Pokemon::Card.where(q: 'supertype:Trainer')
  end

  #------------------------
  # Database
  #------------------------

  def self.save_cards(cards = [])
    #Check existing saved cards
    saved_cards = Card.pluck(:uid)
    #Save card if not exist
    uid_list = []
    cards.each { |card|

      unless (saved_cards.include? card.id) || (uid_list.include? card.id)
        Card.create( uid: card.id, name: card.name, supertype: card.supertype, types: [] )
      end

      uid_list << card.id
    }

    return uid_list

  end

  #------------------------
  # Helper
  #------------------------
  def self.random_card(cards)
    return cards[rand(0...@@valid_types.length)]
  end

  # Return number of cards to complete the deck
  def self.remainder_cards_number(cards)
    return @@deck_size - cards.length
  end

  def self.random_type
    @@valid_types[rand(0...@@valid_types.length)]
  end

end