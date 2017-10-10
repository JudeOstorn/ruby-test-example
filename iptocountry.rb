require 'ipaddr'

module IpToCountry
  IPS_ARRAY = []

  def self.find_country(ip)
    IPS_ARRAY.each do |row|
      if ip.between?(row[0], row[1])
        p "result: #{row[2].to_sym}"
        break
      end
    end
  end

  def self.read_from_file(file_name)
    ips_fields_array = []
    ips_fields = File.readlines(file_name)
    ips_fields.each do |line|
      next if line[0] == '#'
      ip_from = line.split(',')[0].slice(1..-2).to_i
      ip_to = line.split(',')[1].slice(1..-2).to_i
      country = line.split(',')[6].slice(1..-2)
      IPS_ARRAY << [ip_from, ip_to, country.chop]
    end
    IPS_ARRAY.freeze
  end
end

ips_array = IpToCountry.read_from_file('IpToCountry.csv')
#i = ARGV.join(" ")
IpToCountry.find_country(Anet1 = IPAddr.new(ARGV.join(" ")).to_i())
