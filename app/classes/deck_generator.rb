require 'pokemon_tcg_sdk'

class DeckGenerator

    @@validTypes = []

    def create(type)
    end

    protected
    def initValidTypes()
        Pokemon::Type.all();
    end

end