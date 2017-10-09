# расчитывается, что можно будет в дальнейшем превратить это в сторонний код
# которому ты отдаёшь параметры не задумываясть над внутренностями.
# просто require 'search_points'
# val = Search_parametrs.new(radius, center, points)
# any_val = val.search_points  # => result
#
# Вариантов решения просто море. выбирай любой. я даже не знаю какой когда правильный.

module SearchPoints
  def search_points(points: [[43, 54], [65, 56]])
    result = []

    points.each do |point|
      if ((point[0] - center[0])**2 + (point[1] - center[1])**2) <= radius**2
        result << point
      end
    end

    result
  end
end

class Circle
  attr_accessor :radius, :center

  include SearchPoints

  def initialize(radius: 5, center: [56.123124, 72.123124])
    @radius = radius
    @center = center
  end
end

radius = 10
center = [56.123124, 72.123124]
points = [[56, 76], [34, 12], [43, 54], [65, 156], [57, 65], [58, 63]]

params = Circle.new(radius: radius, center: center)

a = params.search_points(points: points)
p a
