require 'ipaddr'
require 'csv'

# Entry = Struct.new(:range, :country)

class Entry
  attr_accessor :range, :country
  def initialize(range, country)
    @range = range
    @country = country
  end
end

module IpToCountry
  def self.read_from_file(file_name)
    array = []
    CSV.foreach(file_name, quote_char: "\x00", skip_lines: '\#') do |row|
      range = (row[0].slice(1..-2).to_i)..(row[1].slice(1..-2).to_i)
      country = row[6].slice(1..-2)
      array << Entry.new(range, country)
    end
    array
  end

  def self.binary_search(ips: nil, ip: 16_909_060)
    if ips.size == 1
      ips.first
    elsif ip < ips[ips.size / 2 - 1].range.last
      binary_search(ips: ips[0..ips.size / 2 - 1], ip: ip)
    elsif ip > ips[ips.size / 2].range.first
      binary_search(ips: ips[ips.size / 2..ips.size], ip: ip)
    end
  end
end

array = IpToCountry.read_from_file('IpToCountry.csv')
ip = IPAddr.new(ARGV.join(' ')).to_i
p "Мы ищем: #{ARGV.join(' ')} <=> #{ip}"
p result = IpToCountry.binary_search(ips: array, ip: ip)
p "Искомый ip находится в #{result.country}"
