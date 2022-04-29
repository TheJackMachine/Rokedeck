class CreateJoinTableCardsDecks < ActiveRecord::Migration[7.0]
  def change
    create_join_table :cards, :decks do |t|
      t.index [:card_id, :deck_id]
      t.index [:deck_id, :card_id]
    end
    
    add_foreign_key :cards_decks, :cards, on_delete: :cascade
    add_foreign_key :cards_decks, :decks, on_delete: :cascade

  end
end
