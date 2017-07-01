class CreateStacks < ActiveRecord::Migration[5.1]
  def change
    create_table :stacks do |t|
      t.string :name, null: false, limit: 126
      t.text :pairs_order, null: false
      t.timestamp :created_at, null: false
    end
  end
end
