#frozen_string_literal: true

require 'optparse'

# DNSLookup gem namespace.
module DNSLookup
  # DNSLookup::Query class is the main.
  class Query

    # Initializes the core variables and calls the driver methods.
    def initialize
      @type = ''

    # Parses the options passed from command prompt.
      OptionParser.new do |opt|
        opt.banner = "Usage: dnslookup <domain name> [options]"
        opt.on("-m", "--mx", "Return MX records") { @type = 'mx' }
        opt.on("-a", "--aname", "Return A name records") { @type = 'a' }
        opt.on("-c", "--cname", "Return C name records") { @type = 'c' }
        opt.on("-t", "--txt", "Return TXT records") { @type = 'txt' }
        opt.on("-s", "--server=SERVER", "Specify specific name server to query") do |v|
          @single_server = v
        end
        opt.on("-h", "--help", "Prints this help") do
          puts opt
          exit
        end
      end.parse!

      # Get domain from command line arguments.
      @domain = ARGV.shift

      setup_query_servers
      query_with_options
    end

    # Sets up the DNS servers to query.
    def setup_query_servers
      @servers = []

      if @single_server
        @servers << @single_server
      else
        @servers = ['8.8.8.8', '8.8.4.4']
      end
    end

    # Query name servers for specific records or entire zone if @type is blank or unknown.
    def query_with_options
      case @type
      when 'mx'
        query_command('mx')
      when 'a'
        query_command('a')
      when 'c'
        query_command('c')
      when 'txt'
        query_command('txt')
      else
        query_command('any')
      end
    end

    # Query command to execute.
    def query_command(type)
      @servers.each do |server|
        if type == 'any'
          check = `dig @#{server} #{type} #{@domain}`
        else
          check = `dig @#{server} #{@domain} #{type} +short`
        end

        puts "Checking servers: #{server}"
        puts check
        puts
      end
    end
  end
end
