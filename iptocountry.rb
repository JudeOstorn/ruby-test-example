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

  def self.search_tree(node: 1, vl: 4, vr: 5, ip: 16_777_216)
    unless TREE[node].nil?
      a1 = TREE[node][0].first.to_i
      a2 = TREE[node][0].last.to_i
      p node
      if ip.between?(a1, a2)
        return TREE[node][1]
      end
    end
    vm = vl + (vr - vl) / 2
    ql = search_tree(node: (2 * node + 1).to_i, vl: vl, vr: vm.to_i, ip: ip)
    qr = search_tree(node: (2 * node + 2).to_i, vl: (vm + 1), vr: vr, ip: ip)
    (ql + qr)
  end
end

IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.build_tree
# p IpToCountry::ARRAY[1][0]
#p a = IpToCountry::TREE[524287][0]
#a1 = a.first
#a2 = a.last
#ip = IPAddr.new(ARGV.join(' ')).to_i
#p ip.between?(a1, a2)
p a = IpToCountry.search_tree(node: 1, vl: 4, vr: 5, ip: ip = IPAddr.new(ARGV.join(' ')).to_i)
# ARRAY[0..NUM_ARR/8]
# p IpToCountry::ARRAY[0..69782].size

# p IpToCountry::TREE
# a = IpToCountry::TREE[1][0]
# b = IpToCountry::TREE[1][-2]
# p a#.size
# p b
# p ips_fields.size
# p IpToCountry::ARRAY[0][0]
# IpToCountry.find_country(ip = IPAddr.new(ARGV.join(' ')).to_i)
