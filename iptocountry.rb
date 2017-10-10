require 'ipaddr'
require 'csv'

module IpToCountry
  def self.find_country(ip, file)
    file.find { |row| p row[6].slice(1..-2) if ip.between?(row[0].slice(1..-2).to_i, row[1].slice(1..-2).to_i) }
  end

  def self.read_from_file(file_name)
    ips_fields = CSV.read(file_name, quote_char: "\x00", skip_lines: '\#')

    ips_fields
  end
end

ips_fields = IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.find_country(ip = IPAddr.new(ARGV.join(' ')).to_i, ips_fields)
