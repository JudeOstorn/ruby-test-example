#require 'pry'

class MisterTwister
  attr_accessor :arrays

  # Create the object
  def initialize(array1 = [[4, 19, [1, 6]], nil, [32, 41], 65], array2 = [234, 0, 21, [54]])
    @array1 = array1
    @array2 = array2
    #@array1 = Array.new([[4, 19], nil, [32, 41], 65])
  end

  # Say hi to everybody
  def say_hi
  @array1 = test(@array1)
  @array1 = @array
  @array2 = test(@array2)
  @array2 = @array
  p @array1
  p @array2
  hash = arrays_to_hash(@array1, @array2)
  end

protected
  def test(array)  #Обработчик исключений внутри массива. всё приводим к integer
    @array = Array.new
    array.each do |f|
      #Исключение nil
      if f.nil? == true
        f = f.to_i
      end

      #Исключение двумерных++ масивов (ой щас рекурсия будет потому-что я тупой -_-)
      if f.kind_of?(Array) == true
        f = array_exeption(f, 0)
      end

      @array.to_a << f
    end
  end

  def array_exeption(f, b)  #собственно рекурсия. проверка на вложеные массивы вывод сумм а чисел array[index]
    i = f
    i.each do |a|

      if a.kind_of?(Array)
        a = array_exeption(а = a, 0)
      end

      if a.kind_of?(Array) == false
        b += a
      end

    end
    f = b
  end

  def arrays_to_hash(array1, array2)
    i = 0
    hash = Hash.new
    while i < array1.size do
      hash["#{array1[i]}+#{array2[i]}".to_sym] = array1[i]+array2[i]
      i+=1
    end
    p hash
  end

end

    mt = MisterTwister.new
    mt.say_hi


#puts Mister.output
#array1 = [[4, 19], nil, [32, 41], 65]
#array2 = [234, 0, 21, 54]
#hash = Hash[array1.collect { |item| [item, "#{item}"] } ]

#p array1
#p array2
#p hash


# очень наркоманское решение =)... после того как сделал - убедился в этом.  вы простите как массив собирались складывать с числом?
#i = 0
#hash = Hash.new
#while i < array1.size do
#hash["#{array1[i]}+#{array2[i]}".to_sym] = array1[i].to_s+array2[i].to_s
#i+=1
#end
#p hash
