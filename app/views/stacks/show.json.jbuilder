json.partial! 'stack', stack: @stack

if @rankings
  json.rankings(@rankings) do |(card, rating)|
    json.name card.name
    json.ranking rating
  end
end
