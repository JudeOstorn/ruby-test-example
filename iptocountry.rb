require 'ipaddr'

module IpToCountry
  IPS_ARRAY = []

  def self.find_country(ip)
    ip = ip[3] + (ip[2] * 256) + (ip[1] * 256**2) + (ip[0] * 256**3)
    IPS_ARRAY.each do |row|
      if ip.between?(row[0], row[1])
        p "result: #{row[2]}"
        break
      end
    end
  end

=begin
  def self.search_in_file(ip, file_name)
    File.open(file_name, 'r') do |infile|
      while (line = infile.gets)
        next if line[0] == '#'
        ip_from = line.split(',')[0].slice(1..-2).to_i
        ip_to = line.split(',')[1].slice(1..-2).to_i

        if ip.between?(ip_from, ip_to)
          country = line.split(',')[4].slice(1..-2)
          break
        end
      end
      "Country: #{country.nil? ? 'not found' : country}"
    end
  rescue => exception
    puts "Error! #{exception.inspect}"
  end

  def self.const_show
    p IPS_ARRAY[0..4]
  end
=end

  def self.read_from_file(file_name)
    ips_fields_array = []
    ips_fields = File.readlines(file_name)
    ips_fields.each do |line|
      next if line[0] == '#'
      ip_from = line.split(',')[0].slice(1..-2).to_i
      ip_to = line.split(',')[1].slice(1..-2).to_i
      country = line.split(',')[4].slice(1..-2)
      IPS_ARRAY << [ip_from, ip_to, country]
    end
    return IPS_ARRAY
  end
end

ips_array = IpToCountry.read_from_file('IpToCountry.csv')
IpToCountry.find_country(ARGV.first.split('.').map(&:to_i))

#IpToCountry.const_show
#p ips_array[0..5]

# IpToCountry.find_country(ARGV.first.split('.').map(&:to_i))#, 'IpToCountry.csv')
