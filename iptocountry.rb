require 'ipaddr'
require 'csv'

class Entry
  attr_accessor :range, :country
  def initialize(range, country)
    @range = range
    @country = country
  end
end

module IpToCountry
  class << self
    def read_and_search(file_name, ip)
      array = []
      CSV.foreach(file_name, skip_lines: '\#') do |row|
        range = (row[0].to_i)..(row[1].to_i)
        country = row[6]
        array << Entry.new(range, country)
      end
      a = array.bsearch {|x| x.range.last >= ip }
      p a.range
      p a.country
    end
  end
end

IpToCountry.read_from_file('IpToCountry.csv', IPAddr.new(ARGV.join(' ')).to_i)
