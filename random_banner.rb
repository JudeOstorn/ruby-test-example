
def output_banner(array: [1,2,3,4,5], n: 5)
  i = 0
  while i < n
    a = array.shuffle if i == 0
    p a[i]
    i+=1
  end
  return a
end

n = 30
array = (1..n).to_a

a = output_banner(array: array, n: n)
p "первый прогон: #{a}"
a = output_banner(array: array, n: n)
p "второй прогон: #{a}"
p "второй может начаться с того чем закончился предыдущий. шансы равны для всех баннеров"
p "но в условии надо прогнать всего один раз =) "
