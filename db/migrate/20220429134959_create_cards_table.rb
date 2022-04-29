class CreateCardsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :uid, null: false, index: { unique: true }
      t.string :name
      t.string :supertype

      t.timestamps
    end
  end
end
