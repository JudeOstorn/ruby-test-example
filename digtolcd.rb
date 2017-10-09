class LCD
  attr_accessor(:size, :spacing)

  LCD_DISPLAY_DATA = { '0' => [1, 3, 0, 3, 1],
                         '1' => [0, 1, 0, 1, 0],
                         '2' => [1, 1, 1, 2, 1],
                         '3' => [1, 1, 1, 1, 1],
                         '4' => [0, 3, 1, 1, 0],
                         '5' => [1, 2, 1, 1, 1],
                         '6' => [1, 2, 1, 3, 1],
                         '7' => [1, 1, 0, 1, 0],
                         '8' => [1, 3, 1, 3, 1],
                         '9' => [1, 3, 1, 1, 1] }

  LCD_STATES = %w[HORIZONTAL
                    VERTICAL
                    HORIZONTAL
                    VERTICAL
                    HORIZONTAL
                    DONE]

  def initialize(size = 1, spacing = 1)
    @size = size
    @spacing = spacing
  end

  def display(digits)
    states = LCD_STATES.reverse
    0.upto(LCD_STATES.length) do |i|
      case states.pop
      when 'HORIZONTAL'
        line = ''
        digits.each_byte do |b|
          line += horizontal_segment(
            LCD_DISPLAY_DATA[b.chr][i]
          )
        end
        print line + "\n"
      when 'VERTICAL'
        1.upto(@size) do |_j|
          line = ''
          digits.each_byte do |b|
            line += vertical_segment(
              LCD_DISPLAY_DATA[b.chr][i]
            )
          end
          print line + "\n"
        end
      when 'DONE'
        break
      end
    end
  end

  def horizontal_segment(type)
    case type
    when 1
      ' ' + ('-' * @size) + ' ' + (' ' * @spacing)
    else
      ' ' + (' ' * @size) + ' ' + (' ' * @spacing)
    end
  end

  def vertical_segment(type)
    case type
    when 1
      ' ' + (' ' * @size) + '|' + (' ' * @spacing)
    when 2
      '|' + (' ' * @size) + ' ' + (' ' * @spacing)
    when 3
      '|' + (' ' * @size) + '|' + (' ' * @spacing)
    else
      ' ' + (' ' * @size) + ' ' + (' ' * @spacing)
    end
  end
end

LCD.new(3, 3).display(ARGV.join(' '))
