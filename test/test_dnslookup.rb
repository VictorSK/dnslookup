require 'minitest/autorun'
require 'dnslookup'

class DNSLookupTest < Minitest::Test
  def setup
    ARGV[0] = 'victorkeenan.com'
    out, err = capture_io do
      @dnslookup = DNSLookup.new
    end
  end

  def test_setup_query_servers_single
    @single_server = '1.2.3.4'
    assert @dnslookup.setup_query_servers, '1.2.3.4'
  end

  def test_setup_query_servers
    test_servers = ['8.8.8.8', '8.8.4.4']
    assert @dnslookup.setup_query_servers, ['8.8.8.8', '8.8.4.4']
  end
end
