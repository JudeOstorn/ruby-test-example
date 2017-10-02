#срочно модифицировать это всё в гем! а после отделаться парой строк

module HashMaker
   # Украдено и переделано!

  def self.calculate(array1, array2)
    array = array1 + array2

    p 'Игнорировать nil?(y/n)'
    @a = gets.chomp
    if @a.downcase == "y"
      array = array.flatten.compact
    end

    array = array.flatten.each_with_object(Hash.new { 0 }) do |i, result|
      result[i] += 1
      result
    end
    #p "Result: #{array}"
  end
end

a = HashMaker.calculate(array1 = [[4, 19, [1, 1, 32, "6"]], nil, [32, 41], 65], array2 = [234, nil, 0, "6", 21, [54,21,32,[1,4]]])
p a

p 'Желаете ли вы глянуть первый(неправильный) вариант решения задачи?(y/n)'
#a = gets.chomp
a = 'n'
if a.casecmp('y').zero?

  class MisterTwister
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
      hash = arrays_to_hash(@array1, @array2)

      p "1 массив: #{@array1}"
      p "2 массив: #{@array2}"
      p "хеш суммы ключей одинаково индексируемых: "
      p @hash
    end

    protected

    def exceptions_worker(array) # Обработчик исключений внутри массива. всё приводим к integer
      @array = []
      array.each do |f|

        f = f.to_i if f.nil? == true # Исключение nil

        # Исключение двумерных++ масивов (ой щас рекурсия будет)
        f = array_exeption(f, 0) if f.is_a?(Array) == true

        @array.to_a << f
      end
    end

    def array_exeption(f, b) # собственно рекурсия. проверка на вложеные массивы вывод сумм а чисел array[index]
      i = f
      i.each do |a|
        a = array_exeption(а = a, 0) if a.is_a?(Array)

        b += a if a.is_a?(Array) == false
      end
      b
    end

    def arrays_to_hash(array1, array2)
      # вот по условию задачи этот экшн создаёт хеш,
      # ключами которого будут числа из обоих массивов array1 и array2, а соотв. значениями-сумма,  #Иииии.... тут почему-то Я решил что сумма ключей.
      # сколько раз встречается число как в первом, так и во втором массиве.  # а вот это я то-ли не понял, то-ли что.
      i = 0
      @hash = {}
      while i < array1.size
        @hash["#{array1[i]}+#{array2[i]}".to_sym] = array1[i] + array2[i]
        i += 1
      end

    end
  end

  mt = MisterTwister.new
  mt.say_hi

end
