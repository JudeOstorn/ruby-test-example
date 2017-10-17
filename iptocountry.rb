require 'ipaddr'
require 'csv'

# ALL IP information from file
class IpInfo
  Entry = Struct.new(:ip_from,
                     :ip_to,
                     :registry,
                     :assigned,
                     :ctry,
                     :cntry,
                     :country)

  def initialize(file_name)
    @file_name = file_name
    @ip_info = []
    read_file
  end

  def read_file
    CSV.foreach(@file_name, skip_lines: '\#') do |row|
      @ip_info << Entry.new(row[0].to_i,  # ip_from
                            row[1].to_i,  # ip_to
                            row[2],       # registry
                            row[3].to_i,  # assigned
                            row[4],       # ctry
                            row[5],       # cntry
                            row[6])       # country
    end
  end

  def search(ip)
    @ip_info.bsearch { |x| x.ip_to >= ip }
  end
end

p IpInfo.new('IpToCountry.csv').search(IPAddr.new(ARGV.first).to_i).country
