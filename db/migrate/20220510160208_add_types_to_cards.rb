class AddTypesToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :types, :json
  end
end
