require 'pokemon_tcg_sdk'

class DeckGenerator

    @@valid_types = []
    @@type_max_range = 16
    @@type_min_range = 12
    @@energy_number = 10
    @@deck_size = 60

    def self.create(type)
        self.init_valid_types
        self.validate_type(type)
        self.generate_deck(type)
    end


    def self.generate_deck(type)

        self.validate_type(type)
        # 1 - Add 12 - 16 pokemon card of specific type
        cards = self.add_pokemon_cards(type, self.number_of_pokemon_cards)

        # 2 - Add 10 energy cards
        cards = cards.concat(cards)

        # 3 - Add training card
        cards.concat(self.add_trainerCards(self.get_remainder_cards_number(cards)))

    end


    protected
    
    #
    # Add 12 - 16 pokemon card of specific type
    #
    def self.add_pokemon_cards(type, number)
        pokemon_cards = self.fetch_pokemon_type(type)
        cards = []
        for n in 0...number
            cards << pokemon_cards[rand(0...pokemon_cards.length)]
        end
        return cards
    end

    #
    # Add 10 energy cards
    #
    def self.add_energy_cards(type, number)
        energy_cards = self.fetch_energy_type(type)
        cards = []
        for n in 0...number
            cards << self.add_energy_cards(type, @@energy_number)
        end
    end

    #
    # Add training card 
    #

    def self.add_trainerCards(number)
        trainer_cards = self.fetch_training_card
        cards = []
        occurences = []
        for n in 0...number

            selected_card = self.random_card(trainer_cards)

            if !occurences.key?(selected_card.name)
                occurences[selected_card.name] = 1
            else
                occurences[selected_card.name] += 1
            end
            
            cards << selected_card

        end

        return cards
    end

    # 
    def self.number_of_pokemon_cards
        rand(@@type_max_range..@@type_min_range)
    end

    # return a type
    def self.check_type(type)
        @@valid_types = @@valid_types[rand(0...@@valid_types.length)] if type.empty? 
    end

    # init types with pokemon API
    def self.init_valid_types
        @@valid_types = Pokemon::Type.all if @@valid_types.empty?
    end

    # validate the type
    def self.validate_type(type)
        if !@@valid_types.include? type 
            raise "Wrong type"
        end 
    end

    #------------------------
    # Helper
    #------------------------
    def random_card(cards)
        return cards[rand(0...@@valid_types.length)]
    end

    # Return number of cards to complete the deck
    def get_remainder_cards_number(cards)
        return self.deck_size - cards.length
    end

    #------------------------
    # Fetching
    #------------------------

    # get pokemon by type
    def self.fetch_pokemon_type(type)
        return Pokemon::Card.where(
            supertype: 'Pokémon',
            types: type
        )
    end

    # get Energy card by type via API
    def self.fetch_energy_type(type)
        return Pokemon::Card.where(
            supertype: 'Energy',
            name: type
        )
    end

    # get Trainer card via API
    def self.fetch_training_card
        return Pokemon::Card.where(supertype: 'Trainer')
    end

end