require 'ipaddr'
require 'csv'

module IpToCountry
  TREE = []   #[range, cntrys] any leaflet

  def self.find_country(ip, file)
    #file.find { |row| p row[6].slice(1..-2) if ip.between?(row[0].slice(1..-2).to_i, row[1].slice(1..-2).to_i) }
    n = file.size
    i = 0
    #TREE << file[i..i+1]
    #p TREE
    while i < n do
      range = (file[i][0].slice(1..-2).to_i)..(file[i][1].slice(1..-2).to_i)
      country = file[i][6].slice(1..-2)
      TREE << [range, country] #..i+1[1]   ,1,6
      i+=2
    end
    p TREE[0..4]
  end

  def self.read_from_file(file_name)
    CSV.read(file_name, quote_char: "\x00", skip_lines: '\#')
  end
end

ips_fields = IpToCountry.read_from_file('IpToCountry.csv')
#p ips_fields.size
IpToCountry.find_country(ip = IPAddr.new(ARGV.join(' ')).to_i, ips_fields)
