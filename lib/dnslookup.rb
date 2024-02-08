# frozen_string_literal: true

require_relative "dnslookup/version"
require 'optparse'

module DNSLookup
  class Error < StandardError; end
  class Query
    DEFAULT_SERVERS = ['8.8.8.8', '8.8.4.4'].freeze

    def initialize
      @type = []
      @single_server = nil
      @domain = ARGV.shift

      parse_options
      setup_query_servers
      query_with_options
    end

    def parse_options
      OptionParser.new do |opt|
        opt.banner = "Usage: dnslookup <domain name> [options]"
        opt.on("-m", "--mx", "Return MX records") { @type << 'mx' }
        opt.on("-a", "--aname", "Return A name records") { @type << 'a' }
        opt.on("-c", "--cname", "Return C name records") { @type << 'c' }
        opt.on("-t", "--txt", "Return TXT records") { @type << 'txt' }
        opt.on("-s", "--server=SERVER", "Specify specific name server to query") do |v|
          @single_server = v
        end
        opt.on("-h", "--help", "Prints this help") do
          puts opt
          exit
        end
        opt.on("-v", "--version", "Prints version") do
          puts DNSLookup::VERSION
          exit
        end
      end.parse!
    end

    def setup_query_servers
      @servers = []

      if @single_server
        @servers << @single_server
      else
        @servers = DEFAULT_SERVERS
      end
    end

    def query_with_options
      if @type.empty?
        query_command('any')
      else
        query_command(@type)
      end
    end

    def query_command(type)
      @servers.each do |server|
        if type == 'any'
          check = `dig @#{server} #{type} #{@domain}`

          puts "Checking servers: #{server} root domain records"
          puts check
          puts
        else
          @type.each do |type|
            check = `dig @#{server} #{@domain} #{type.upcase} +short`

            puts "Checking servers: #{server} for #{type.upcase} records"
            puts check
            puts
          end
        end
      end
    end
  end
end
