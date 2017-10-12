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

    if TREE[node].size == 2#ip.between?(TREE[node][0].first, TREE[node][0].last)
      #p (node - 1) / 2
      #p node
      #p TREE[(((node - 1) / 2)-2)/2]
      return TREE[node]
    end

    p node
    #p vl = IpToCountry::TREE[node][0].first
    #p vr = IpToCountry::TREE[node][-2].first

    l = TREE[node][0..TREE[node].size/2]
    r = TREE[node][TREE[node].size/2..TREE[node].size]
    #p l[-2].class
    p '---'
    p l[0]
    p l[-2]
    p '---'
    p r[0]
    p r[-2]
    p '---'

    p "l = #{l[-2].class}"
    p "r = #{r[0].class}"

    #p r[0]
    #p "левый #{ip - vl}"
    #p "правый #{vr - ip}"
    #if ip - vl < vr - ip
    if r[0].class == String
      r = r[1]
    else
      r = r[0]
    end

      if l[-2].class == String
        if ip < l[-3].last #|| ip > r.first
          p 'left'
          return search_tree(node: (2 * node).to_i, ip: ip)
        elsif ip > r.first
          p 'right'
          return search_tree(node: (2 * node + 1).to_i, ip: ip)
        end
      else
        if ip < l[-2].last #|| ip > r.first
          p 'left'
          return search_tree(node: (2 * node).to_i, ip: ip)
        elsif ip > r.first
          p 'right'
          return search_tree(node: (2 * node + 1).to_i, ip: ip)
        end
      end

  end
end

IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.build_tree
#p ip = IPAddr.new(ARGV.join(' ')).to_i
#ip = 1_477_238_162
#p a1 = IpToCountry::TREE[3][0].first
#p a2 = IpToCountry::TREE[3][-2].last

#1_426_906_514 my ip
#0..4294967295  all ips
#2147483648  center
#p IpToCountry::TREE[4][IpToCountry::TREE[4].size/2..IpToCountry::TREE[4].size/2+10]
#1475612672
#1481965568

#if ip - a1 < a2 - ip
#  p 'left'
#else
#  p 'right'
#end
#p ip - a1
#p a2 - ip   #IpToCountry::TREE.size
#r = IpToCountry::TREE[16][IpToCountry::TREE[16].size/2..IpToCountry::TREE[16].size]
#l = IpToCountry::TREE[16][0..IpToCountry::TREE[16].size/2]
#p l[-2]
#p r[0]
##p IpToCountry::TREE[32][0]

#p ip = IPAddr.new(ARGV.join(' ')).to_i
#p '-'
p ip = 1_426_906_514
p a = IpToCountry.search_tree(node: 1, ip: ip = IPAddr.new(ARGV.join(' ')).to_i)
