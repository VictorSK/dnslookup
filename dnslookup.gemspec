# frozen_string_literal: true

require_relative "lib/dnslookup/version"

Gem::Specification.new do |spec|
  spec.name                   = 'dnslookup'
  spec.version                = DNSLookup::VERSION
  spec.author                 = 'Victor S. Keenan'
  spec.email                  = 'me@victorkeenan.com'
  spec.summary                = "DNS record query CLI gem written in Ruby."
  spec.homepage               = 'https://www.victorkeenan.com/projects/dnslookup/'
  spec.required_ruby_version  = '>= 3.0'
  spec.license                = 'MIT'
  spec.description            = "dnslookup is a DNS record query CLI gem written in Ruby. dnslookup automatically queries multiple public DNS servers or allows you to query a specific DNS server."
  spec.executables            = 'dnslookup'
  spec.require_paths          = ["lib"]
  spec.metadata               = {
    'homepage_uri'            => 'https://www.victorkeenan.com/projects/dnslookup/',
    'bug_tracker_uri'         => 'https://github.com/VictorSK/dnslookup/issues/',
    'changelog_uri'           => 'https://github.com/VictorSK/dnslookup/blob/main/CHANGELOG.md',
    'documentation_uri'       => 'https://github.com/VictorSK/dnslookup/blob/main/README.md',
    'source_code_uri'         => 'https://github.com/VictorSK/dnslookup/',
    'rubygems_mfa_required'   => 'true'
  }
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ .git Rakefile Gemfile])
    end
  end
end
