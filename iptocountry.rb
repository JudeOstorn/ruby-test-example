require 'ipaddr'
require 'csv'

module IpToCountry
  ARRAY = []

  def self.read_from_file(file_name)
    CSV.foreach(file_name, quote_char: "\x00", skip_lines: '\#') do |row|
      range = (row[0].slice(1..-2).to_i)..(row[1].slice(1..-2).to_i)
      country = row[6].slice(1..-2)
      ARRAY << [range, country]
    end
      ARRAY.freeze
  end

  def self.binary_search (ips: ARRAY, ip: 16_909_060)
    if ips.size == 1
      ips
    elsif ip < ips[ips.size/2-1][0].last
      binary_search(ips: ips[0..ips.size/2-1], ip: ip)
    elsif ip > ips[ips.size/2][0].first
      binary_search(ips: ips[ips.size/2..ips.size], ip: ip)
    end
  end

end

begin
  IpToCountry.read_from_file('IpToCountry.csv')
  ip = IPAddr.new(ARGV.join(' ')).to_i
  p "Мы ищем: #{ARGV.join(' ')} <=> #{ip}"
  p result = IpToCountry.binary_search(ip: ip)
  p "Искомый ip находится в #{result[0][1]}"
rescue => exception
  puts "Error! #{exception.inspect}"
end
