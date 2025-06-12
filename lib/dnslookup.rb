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

      if @domain.nil? || @domain.start_with?('-')
        puts "Error: You must specify a domain name.\n\n"
        puts "Usage: dnslookup <domain name> [options]"
        exit 1
      end

      parse_options
      setup_query_servers
      query_with_options
    end

    def parse_options
      OptionParser.new do |opt|
        opt.banner = <<~BANNER
          Usage: dnslookup <domain name> [options]
          Example: dnslookup example.com -a -m -s8.8.8.8
        BANNER
        opt.on("-m", "--mx", "Return MX records") { @type << 'mx' }
        opt.on("-a", "--aname", "Return A name records") { @type << 'a' }
        opt.on("-c", "--cname", "Return C name records") { @type << 'c' }
        opt.on("-t", "--txt", "Return TXT records") { @type << 'txt' }
        opt.on("-s", "--server=SERVER", "Specify specific name server to query") do |v|
          @single_server = v
        end
        opt.on("-A", "--all", "Return all record types") { @type = %w[a mx c txt] }
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

    def query_command(types)
      @servers.each do |server|
        Array(types).each do |type|
          record_type = type == 'any' ? '' : type.upcase
          check = `dig @#{server} #{@domain} #{record_type} +short`
          puts "Checking server: #{server} for #{record_type.empty? ? 'ALL' : record_type} records"
          puts check.empty? ? "(no records found)" : check
          puts
        end
      end
    end
  end
end
