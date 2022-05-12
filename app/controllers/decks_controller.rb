class DecksController < ApplicationController

    def index
        @decks = Deck.all
    end

    def show
        @deck =  Deck.includes(:cards).where(uuid: params[:uuid]).first
    end

    def generate
        if params[:type]
            puts "parameter " + params[:type]
            @deck = DeckGenerator.create(params[:type])
        else
            @deck = DeckGenerator.create
        end
    end

end
