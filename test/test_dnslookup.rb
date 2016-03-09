require 'minitest/autorun'
require 'dnslookup'

class DNSLookupTest < Minitest::Test

  def setup
    ARGV[0] = 'google.com'
  end

  def call_class
    @out, @err = capture_io do
      @dnslookup = DNSLookup.new
    end

  end

  def test_mx_lookup
    ARGV[1] = '-m'
    call_class
    assert_includes @out, '10 aspmx.l.google.com.'
  end

  def test_a_name_lookup
    ARGV[1] = '-a'
    call_class
    assert_includes @out, '65.196.188'
  end

  def test_t_name_lookup
    ARGV[1] = '-t'
    call_class
    assert_includes @out, "v=spf1 include:_spf.google.com ~all"
  end

  def test_c_name_lookup
    ARGV[0] = 'mail.google.com'
    ARGV[1] = '-c'
    call_class
    assert_includes @out, 'googlemail.l.google.com.'
  end

  def test_setup_query_servers_single
    ARGV[1] = '-s8.8.4.4'
    call_class
    assert_equal ['8.8.4.4'], @dnslookup.setup_query_servers
  end

  def test_setup_query_servers
    test_servers = ['8.8.8.8', '8.8.4.4']
    call_class
    assert_equal test_servers, @dnslookup.setup_query_servers
  end
end
