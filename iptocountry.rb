require 'ipaddr'
require 'csv'

module IpToCountry
  IPS_ARRAY = []

  def self.find_country(ip)
    IPS_ARRAY.each do |row|
      if ip.between?(row[0], row[1])
        p "result: #{row[2]}"
        break
      end
    end
  end

  def self.read_from_file(file_name)
    ips_fields_array = []
    ips_fields = CSV.read(file_name, quote_char: "\x00", skip_lines: '\#')
    ips_fields.each do |line|
      next if line[0] == '#'
      ip_from = line[0].slice(1..-2).to_i
      ip_to = line[1].slice(1..-2).to_i
      country = line[6].slice(1..-2)
      IPS_ARRAY << [ip_from, ip_to, country]
    end
    IPS_ARRAY.freeze
  end
end

ips_array = IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.find_country(ip = IPAddr.new(ARGV.join(' ')).to_i)
