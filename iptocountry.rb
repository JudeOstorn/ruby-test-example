require 'ipaddr'
require 'csv'

module IpToCountry
  def self.read_from_file(file_name)
    hash = {}
    CSV.foreach(file_name, skip_lines: '\#') do |row|
      range = (row[0].to_i)..(row[1].to_i)
      country = row[6]
      hash.store(range, country)
    end
    hash
  end

  def self.binary_search(ips: nil, ip: 16_909_060)
    if ips.size == 1
      ips
    elsif ip < ips[ips.size / 2 - 1].last
      binary_search(ips: ips[0..ips.size / 2 - 1], ip: ip)
    elsif ip > ips[ips.size / 2].first
      binary_search(ips: ips[ips.size / 2..ips.size], ip: ip)
    end
  end
end


  hash = IpToCountry.read_from_file('IpToCountry.csv')
  ip = IPAddr.new(ARGV.join(' ')).to_i
  p "Мы ищем: #{ARGV.join(' ')} <=> #{ip}"
  p result = IpToCountry.binary_search(ips: hash.keys[0..hash.size - 1], ip: ip)[0]
  p result.class
  p "Искомый ip находится в #{hash[result]} "
