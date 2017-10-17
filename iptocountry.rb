require 'ipaddr'
require 'csv'

# ALL IP information from file
class IpInfo
  def initialize(file_name)
    Struct.new('Entry',
               :ip_from,
               :ip_to,
               :registry,
               :assigned,
               :ctry,
               :cntry,
               :country)

    @file_name = file_name
    @ip_info = []
    read_file
  end

  def read_file
    CSV.foreach(@file_name, skip_lines: '\#') do |row|
      ip_from = row[0].to_i
      ip_to = row[1].to_i
      registry = row[2]
      assigned = row[3].to_i
      ctry = row[4]
      cntry = row[5]
      country = row[6]
      @ip_info << Struct::Entry.new(ip_from,
                                    ip_to,
                                    registry,
                                    assigned,
                                    ctry,
                                    cntry,
                                    country)
    end
  end

  def search(ip)
    @ip_info.bsearch { |x| x.ip_to >= ip }
  end
end

ip_info = IpInfo.new('IpToCountry.csv')
p ip_info.search(IPAddr.new(ARGV.first).to_i).country
