require 'pokemon_tcg_sdk'

class DecksController < ApplicationController


    def index
        # puts Pokemon::Card.find('xy7-57')
        
        #deck = DeckGenerator.fetch_pokemon_type('Fire')
        #deck2 = DeckGenerator.fetch_energy_type('Fire')
        #deck3 = DeckGenerator.fetch_training_card

        deck = DeckGenerator.create

        render :json => 'ok'
        # render :json => Pokemon::Card.find('xy7-57')

    end


end