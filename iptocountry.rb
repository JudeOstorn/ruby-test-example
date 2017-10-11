require 'ipaddr'
require 'csv'

module IpToCountry
  ARRAY = [] # (1..10).to_a
  TREE = []

  def self.find_country(_ip, _file)
    # file.find { |row| p row[6].slice(1..-2) if ip.between?(row[0].slice(1..-2).to_i, row[1].slice(1..-2).to_i) }
    # n = file.size
    # i = 0
    # TREE << file[i..i+1]
    # p TREE
    # while i < n do
    #  range = (file[i][0].slice(1..-2).to_i)..(file[i][1].slice(1..-2).to_i)
    #  country = file[i][6].slice(1..-2)
    #  TREE << [range, country] #..i+1[1]   ,1,6
    #  i+=2
    # end
    # p TREE[0..4]
  end

  def self.read_from_file(file_name)
    CSV.foreach(file_name, quote_char: "\x00", skip_lines: '\#') do |row|
      range = (row[0].slice(1..-2).to_i)..(row[1].slice(1..-2).to_i)
      country = row[6].slice(1..-2)
      ARRAY << [range, country]
    end
    # num_arr = ARRAY.size
  end

  def self.build_tree(i: 1, tl: 0, tr: (ARRAY.size - 1))
    if tl == tr
      TREE[i] = ARRAY[tl] # [0]
    else
      tm = tl + (tr - tl) / 2
      build_tree(i: (2 * i + 1), tl: tl, tr: tm)
      build_tree(i: (2 * i + 2), tl: (tm + 1), tr: tr)
      TREE[i] = TREE[2 * i + 1] + TREE[2 * i + 2]
    end
  end

  def self.search_tree(node: 1, ip: 16_777_216)

    if TREE[node].size == 2#ip.between?(TREE[node][0].first, TREE[node][0].last)
      #p (node - 1) / 2
      #p node
      #p TREE[(((node - 1) / 2)-2)/2]
      return TREE[node]
    end

    if ip - (TREE[node][0].first) < (TREE[node][-2].last) - ip
      return search_tree(node: (2 * node + 1).to_i, ip: ip)
    else
      return search_tree(node: (2 * node + 2).to_i, ip: ip)
    end
  end
end

IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.build_tree
#p ip = IPAddr.new(ARGV.join(' ')).to_i
#p a1 = IpToCountry::TREE[3][0].first
#p a2 = IpToCountry::TREE[4][-2].last
#if a1 - ip  < a2 - ip
#  p 'left'
#else
#  p 'right'
#end
#p a1 - ip
#p a2 - ip   IpToCountry::TREE.size
#p IpToCountry::TREE[655359..655360]

p ip = IPAddr.new(ARGV.join(' ')).to_i
p a = IpToCountry.search_tree(node: 1, ip: ip = IPAddr.new(ARGV.join(' ')).to_i)
