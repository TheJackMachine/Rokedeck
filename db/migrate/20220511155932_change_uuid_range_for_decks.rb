class ChangeUuidRangeForDecks < ActiveRecord::Migration[7.0]
  def change
    change_column :decks, :uuid, "char (36)"
  end
end
