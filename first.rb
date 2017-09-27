#Даны два списка (массива) из различных (возможно повторяющихся) целых чисел,
#а также могут быть и “дырки” - nil’ы, при этом каждый из массивов может
#в качестве элементов содержать подмассивы также из целых чисел.
#Пример: массив array1 = [[4, 19], nil, [32, 41], 65], array2 = [234, 0, 21, [54]].
#Необходимо написать программу на ruby, на выходе которой будет хеш,
#ключами которого будут числа из обоих массивов a и b, а соотв. значениями-сумма,
#сколько раз встречается число как в первом, так и во втором массиве.


class MisterTwister
  attr_accessor :arrays

  # Create the object
  def initialize(array1 = [[4, 19, [1, 6]], nil, [32, 41], 65], array2 = [234, 0, 21, [54]])
    @array1 = array1
    @array2 = array2
  end

  # start action
  def say_hi
  @array1 = exceptions_worker(@array1)
  @array1 = @array
  @array2 = exceptions_worker(@array2)
  @array2 = @array
  p @array1
  p @array2
  hash = arrays_to_hash(@array1, @array2)
  end

protected
  def exceptions_worker(array)  #Обработчик исключений внутри массива. всё приводим к integer
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

  def arrays_to_hash(array1, array2)  #вот по условию задачи этот экшн создаёт хеш,
  #ключами которого будут числа из обоих массивов array1 и array2, а соотв. значениями-сумма,
  #сколько раз встречается число как в первом, так и во втором массиве.
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
