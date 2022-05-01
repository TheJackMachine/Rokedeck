require 'pokemon_tcg_sdk'

class DecksController < ApplicationController


    def index
        # puts Pokemon::Card.find('xy7-57')
        
        deck = DeckGenerator.create('Fire')

        render :json => 'test'
        # render :json => Pokemon::Card.find('xy7-57')

    end


end