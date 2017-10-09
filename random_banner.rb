size = 12431231
array = (1..size).to_a
history = []

(size + 5).times do
  history.clear if history.size >= array.size
  current_item = (array - history).sample
  history << current_item
  p "Текущий элемент: #{current_item}"
  p "история: #{history}"
end
