# frozen_string_literal: true

require "test_helper"

class DNSLookupTest < Minitest::Test
  def build_status(success)
    stub(success?: success)
  end

  def test_that_it_has_a_version_number
    refute_nil ::DNSLookup::VERSION
  end

  def setup
    @original_argv = ARGV.dup
  end

  def teardown
    ARGV.replace(@original_argv)
  end

  def set_argv(*args)
    ARGV.replace(args)
  end

  def capture_cli_exit
    status = nil
    out, err = capture_io do
      begin
        DNSLookup::CLI.run(argv: ARGV)
      rescue SystemExit => error
        status = error.status
      end
    end

    [status, out, err]
  end

  def expect_dig_lookup(server:, domain:, type:, response:)
    status = build_status(true)
    Open3.expects(:capture3)
      .with('dig', "@#{server}", domain, type, '+short')
      .returns(["#{response}\n", '', status])
  end

  def test_mx_lookup
    expect_dig_lookup(server: '8.8.8.8', domain: 'victorkeenan.com', type: 'MX', response: '10 mail.victorkeenan.com')

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', types: ['mx'], servers: ['8.8.8.8']).run
    end

    assert_includes out, 'Checking server: 8.8.8.8 for MX records'
    assert_includes out, '10 mail.victorkeenan.com'
  end

  def test_a_name_lookup
    expect_dig_lookup(server: '8.8.8.8', domain: 'victorkeenan.com', type: 'A', response: '64.225.21.207')

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', types: ['a'], servers: ['8.8.8.8']).run
    end

    assert_includes out, 'Checking server: 8.8.8.8 for A records'
    assert_includes out, '64.225.21.207'
  end

  def test_t_name_lookup
    expect_dig_lookup(server: '8.8.8.8', domain: 'victorkeenan.com', type: 'TXT', response: 'v=spf1 mx a ip4:64.225.21.207 ~all')

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', types: ['txt'], servers: ['8.8.8.8']).run
    end

    assert_includes out, 'Checking server: 8.8.8.8 for TXT records'
    assert_includes out, 'v=spf1 mx a ip4:64.225.21.207 ~all'
  end

  def test_c_name_lookup
    expect_dig_lookup(server: '8.8.8.8', domain: 'ftp.victorkeenan.com', type: 'CNAME', response: 'victorkeenan.com.')

    out, = capture_io do
      DNSLookup::Query.new(domain: 'ftp.victorkeenan.com', types: ['c'], servers: ['8.8.8.8']).run
    end

    assert_includes out, 'Checking server: 8.8.8.8 for CNAME records'
    assert_match(/victorkeenan\.com/, out)
  end

  def test_cli_uses_single_server
    set_argv('victorkeenan.com', '-s8.8.4.4')
    query = mock
    DNSLookup::Query.expects(:new)
      .with(domain: 'victorkeenan.com', types: [], servers: ['8.8.4.4'], out: $stdout)
      .returns(query)
    query.expects(:run)

    DNSLookup::CLI.run(argv: ARGV)
  end

  def test_cli_uses_default_servers
    set_argv('victorkeenan.com')
    query = mock
    DNSLookup::Query.expects(:new)
      .with(domain: 'victorkeenan.com', types: [], servers: ['8.8.8.8', '8.8.4.4'], out: $stdout)
      .returns(query)
    query.expects(:run)

    DNSLookup::CLI.run(argv: ARGV)
  end

  def test_cli_passes_record_types_to_query
    set_argv('victorkeenan.com', '-a', '-m')
    query = mock
    DNSLookup::Query.expects(:new)
      .with(domain: 'victorkeenan.com', types: ['a', 'mx'], servers: ['8.8.8.8', '8.8.4.4'], out: $stdout)
      .returns(query)
    query.expects(:run)

    DNSLookup::CLI.run(argv: ARGV)
  end

  def test_default_lookup_queries_a_records
    query = DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8'])
    query.expects(:query_command).with('a')

    query.run
  end

  def test_query_command_invokes_dig_without_shell_interpolation
    status = stub(success?: true)
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'A', '+short')
      .returns(["93.184.216.34\n", '', status])

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('a')
    end

    assert_includes out, 'Checking server: 8.8.8.8 for A records'
    assert_includes out, '93.184.216.34'
  end

  def test_query_command_reports_failed_lookup
    failed_status = build_status(false)
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'A', '+short')
      .returns(['', 'connection timed out', failed_status])

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('a')
    end

    assert_includes out, 'Checking server: 8.8.8.8 for A records'
    assert_includes out, '(query failed: connection timed out)'
  end

  def test_query_command_reports_no_records_found_for_empty_successful_lookup
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'A', '+short')
      .returns(['', '', build_status(true)])

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('a')
    end

    assert_includes out, '(no records found)'
  end

  def test_query_command_reports_failed_lookup_without_error_output
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'A', '+short')
      .returns(['', '', build_status(false)])

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('a')
    end

    assert_includes out, '(query failed)'
  end

  def test_query_command_reports_missing_dig_binary
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'A', '+short')
      .raises(Errno::ENOENT)

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('a')
    end

    assert_includes out, '(query failed: dig command not found)'
  end

  def test_query_command_upcases_unknown_record_type
    Open3.expects(:capture3)
      .with('dig', '@8.8.8.8', 'victorkeenan.com', 'NS', '+short')
      .returns(["ns1.example.com.\n", '', build_status(true)])

    out, = capture_io do
      DNSLookup::Query.new(domain: 'victorkeenan.com', servers: ['8.8.8.8']).query_command('ns')
    end

    assert_includes out, 'Checking server: 8.8.8.8 for NS records'
    assert_includes out, 'ns1.example.com.'
  end

  def test_help_without_domain
    ARGV.replace(['-h'])

    status, out, = capture_cli_exit

    assert_equal 0, status
    assert_includes out, 'Usage: dnslookup <domain name> [options]'
  end

  def test_version_without_domain
    ARGV.replace(['-v'])

    status, out, = capture_cli_exit

    assert_equal 0, status
    assert_includes out, DNSLookup::VERSION
  end

  def test_missing_domain_exits_with_error
    ARGV.replace([])

    status, out, = capture_cli_exit

    assert_equal 1, status
    assert_includes out, 'Error: You must specify a domain name.'
  end

  def test_domain_that_looks_like_an_option_exits_with_error
    ARGV.replace(['--', '-example.com'])

    status, out, = capture_cli_exit

    assert_equal 1, status
    assert_includes out, 'Error: You must specify a domain name.'
  end

  def test_executable_delegates_to_cli
    set_argv('victorkeenan.com', '-a')
    DNSLookup::CLI.expects(:run).with(argv: ['victorkeenan.com', '-a'])

    load File.expand_path('../bin/dnslookup', __dir__)
  end
end
