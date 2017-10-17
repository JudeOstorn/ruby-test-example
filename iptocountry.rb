require 'ipaddr'
require 'csv'

# IP information from file
class IpInfo
  def initialize(file_name)
    Struct.new('Entry', :range, :country)
    @file_name = file_name
    @ip_info = []
    read_file
  end

  def read_file
    CSV.foreach(@file_name, skip_lines: '\#') do |row|
      range = (row[0].to_i)..(row[1].to_i)
      country = row[6]
      @ip_info << Struct::Entry.new(range, country)
    end
  end

  def search(ip)
    @ip_info.bsearch { |x| x.range.last >= ip }
  end
end

a = IpInfo.new('IpToCountry.csv')
p a.search(IPAddr.new(ARGV.first).to_i).country
