class CreateDecksTable < ActiveRecord::Migration[7.0]
  def change
    create_table :decks do |t|
      t.column :uuid, "char (32)", null: false, index: { unique: true } 
      t.string :name
      t.string :focus
      t.timestamps
    end
  end
end
