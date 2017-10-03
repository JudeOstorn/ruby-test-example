# расчитывается, что можно будет в дальнейшем превратить это в сторонний код
# которому ты отдаёшь параметры не задумываясть над внутренностями.
# просто require 'search_points'
# val = Search_parametrs.new(radius, center, points)
# any_val = val.search_points  # => result
#
# Вариантов решения просто море. выбирай любой. я даже не знаю какой когда правильный.



module Search_points
  def search_points
    result = []

    self.points.each do |point|
      if ((point[0] - self.center[0])**2 + (point[1] - self.center[1])**2) <= self.radius**2
        result << point
      end
    end

    return result

  end
end

class Search_parametrs
  attr_accessor :radius, :center, :points

  include Search_points

  def initialize(radius, center, points)
    @radius = radius
    @center = center
    @points = points
  end
end



  radius = 10
  center = [56.123124,72.123124]
  points = [[56,76],[34,12],[43,54],[65,156]]

  params = Search_parametrs.new(radius, center, points)

  a = params.search_points
  p a
