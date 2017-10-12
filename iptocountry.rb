require 'ipaddr'
require 'csv'

module IpToCountry
  ARRAY = []
  TREE = []

  def self.read_from_file(file_name)
    CSV.foreach(file_name, quote_char: "\x00", skip_lines: '\#') do |row|
      range = (row[0].slice(1..-2).to_i)..(row[1].slice(1..-2).to_i)
      country = row[6].slice(1..-2)
      ARRAY << [range, country]
    end
      ARRAY.freeze
  end

  def self.build_tree(i: 1, tl: 0, tr: (ARRAY.size - 1))
    if tl == tr
      TREE[i] = ARRAY[tl] # [0]
    else
      tm = tl + (tr - tl) / 2
      build_tree(i: (2 * i), tl: tl, tr: tm)
      build_tree(i: (2 * i + 1), tl: (tm + 1), tr: tr)
      TREE[i] = TREE[2 * i] + TREE[2 * i + 1]
    end
  end

  def self.search_tree(node: 1, ip: 16_777_216)
    if TREE[node].size == 2
      return TREE[node]
    end
    left_node = TREE[node][0..TREE[node].size / 2]
    right_node = TREE[node][TREE[node].size / 2..TREE[node].size]
    right_edge = if right_node[0].class == String
                   right_node[1]
                 else
                   right_node[0]
                 end

    if left_node[-2].class == String
      if ip < left_node[-3].last
        return search_tree(node: (2 * node).to_i, ip: ip)
      elsif ip > right_edge.first
        return search_tree(node: (2 * node + 1).to_i, ip: ip)
      end
    else
      if ip < left_node[-2].last
        return search_tree(node: (2 * node).to_i, ip: ip)
      elsif ip > right_edge.first
        return search_tree(node: (2 * node + 1).to_i, ip: ip)
      end
    end
  rescue => exception
    puts "Error! #{exception.inspect}"
  end

  def self.debug_search_tree(node: 1, ip: 16_777_216)
    if TREE[node].size == 2
      p ' '
      p 'мы достигли дна капитан!!'
      p ' '
      return TREE[node]
    end
    p ' '
    p "мы на #{node} узле"
    p ' '
    left_node = TREE[node][0..TREE[node].size / 2]
    right_node = TREE[node][TREE[node].size / 2..TREE[node].size]

    p '-левая часть-'
    p "левый край -:#{left_node[0]}"
    p "правый край :#{left_node[-2]}"
    p ' '
    p '-правая часть-'
    p "левый край -:#{right_node[0]}"
    p "правый край :#{right_node[-2]}"
    p ' '

    right_edge = if right_node[0].class == String
          right_node[1]
        else
          right_node[0]
        end

    if left_node[-2].class == String
      if ip < left_node[-3].last # || ip > r.first
        p 'поворачеваем на лево капитан!!'
        return search_tree(node: (2 * node).to_i, ip: ip)
      elsif ip > right_edge.first
        p 'поворачеваем на право капитан!!'
        return search_tree(node: (2 * node + 1).to_i, ip: ip)
      end
    else
      if ip < left_node[-2].last # || ip > r.first
        p 'поворачеваем на лево капитан!!'
        return search_tree(node: (2 * node).to_i, ip: ip)
      elsif ip > right_edge.first
        p 'поворачеваем на право капитан!!'
        return search_tree(node: (2 * node + 1).to_i, ip: ip)
      end
    end
  rescue => exception
    puts "Error! #{exception.inspect}"
  end
end

begin
  IpToCountry.read_from_file('IpToCountry.csv')
  IpToCountry.build_tree
  ip = IPAddr.new(ARGV.join(' ')).to_i
  p "Мы ищем: #{ARGV.join(' ')} <=> #{ip}"

  #раскомментируйте строку ниже и закоментируйте (p result = IpToCountry.search_tree(ip: ip))
  # если хотите узнать данные на каждом узле
  #p result = IpToCountry.debug_search_tree(ip: ip)
  p result = IpToCountry.search_tree(ip: ip)
  
  p ' '
  p "Искомый ip находится в #{result[1]}"
rescue => exception
  puts "Error! #{exception.inspect}"
end
