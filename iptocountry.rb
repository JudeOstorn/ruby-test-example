require 'ipaddr'
require 'csv'

module IpToCountry
  IPS_HASH = {}

  def self.read_from_file(file_name)
    CSV.foreach(file_name, skip_lines: '\#') do |row|
      range = (row[0].to_i)..(row[1].to_i)
      country = row[6]
      IPS_HASH.store(range, country)
    end
    IPS_HASH.freeze
  end

  def self.binary_search(ips: IPS_HASH.keys[0..IPS_HASH.size - 1], ip: 16_909_060)
    if ips.size == 1
      ips
    elsif ip < ips[ips.size / 2 - 1].last
      binary_search(ips: ips[0..ips.size / 2 - 1], ip: ip)
    elsif ip > ips[ips.size / 2].first
      binary_search(ips: ips[ips.size / 2..ips.size], ip: ip)
    end
  end
end

begin
  IpToCountry.read_from_file('IpToCountry.csv')
  ip = IPAddr.new(ARGV.join(' ')).to_i
  p "Мы ищем: #{ARGV.join(' ')} <=> #{ip}"
  p result = IpToCountry.binary_search(ip: ip)
  p "Искомый ip находится в #{IpToCountry::IPS_HASH[result[0]]}"
rescue => exception
  puts "Error! #{exception.inspect}"
end
