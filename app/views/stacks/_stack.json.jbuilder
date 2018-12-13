json.call(stack, :name, :created_at, :pairs_order)
json.id stack.to_param
json.cards stack.cards.order(id: :asc), partial: 'cards/card', as: :card
