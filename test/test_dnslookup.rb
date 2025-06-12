# frozen_string_literal: true

require "test_helper"

class DNSLookupTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DNSLookup::VERSION
  end

  def setup
    @original_argv = ARGV.dup
    ARGV[0] = 'victorkeenan.com'
  end

  def teardown
    ARGV.replace(@original_argv)
  end

  def set_argv(domain: 'victorkeenan.com', flag: nil)
    ARGV[0] = domain
    ARGV[1] = flag if flag
  end

  def call_class
    @out, @err = capture_io { @dnslookup = DNSLookup::Query.new }
  end

  def test_mx_lookup
    DNSLookup::Query.any_instance.stubs(:lookup_mx).returns("10 mail.victorkeenan.com")
    set_argv(flag: '-m')
    call_class
    assert_includes @out, '10 mail.victorkeenan.com', "Expected MX record '10 mail.victorkeenan.com' in output, got: #{@out.inspect}"
  end

  def test_a_name_lookup
    DNSLookup::Query.any_instance.stubs(:lookup_a).returns("64.225.21.207")
    set_argv(flag: '-a')
    call_class
    assert_includes @out, '64.225.21.207', "Expected A record '64.225.21.207' in output, got: #{@out.inspect}"
  end

  def test_t_name_lookup
    DNSLookup::Query.any_instance.stubs(:lookup_txt).returns("v=spf1 mx a ip4:64.225.21.207 ~all")
    set_argv(flag: '-t')
    call_class
    assert_includes @out, "v=spf1 mx a ip4:64.225.21.207 ~all", "Expected TXT record in output, got: #{@out.inspect}"
  end

  def test_c_name_lookup
    DNSLookup::Query.any_instance.stubs(:lookup_cname).returns("ftp.victorkeenan.com")
    set_argv(domain: 'ftp.victorkeenan.com', flag: '-c')
    call_class
    assert_match /victorkeenan\.com/, @out, "Expected CNAME containing 'victorkeenan.com' in output, got: #{@out.inspect}"
  end

  def test_setup_query_servers_single
    ARGV[1] = '-s8.8.4.4'
    call_class
    assert_equal ['8.8.4.4'], @dnslookup.setup_query_servers, "Expected single server ['8.8.4.4'], got: #{@dnslookup.setup_query_servers.inspect}"
  end

  def test_setup_query_servers
    test_servers = ['8.8.8.8', '8.8.4.4']
    call_class
    assert_equal test_servers, @dnslookup.setup_query_servers, "Expected servers #{test_servers.inspect}, got: #{@dnslookup.setup_query_servers.inspect}"
  end
end
