# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                   = 'dnslookup'
  spec.version                = '0.1.6'
  spec.date                   = '2024-02-06'
  spec.summary                = "DNS record query CLI gem written in Ruby."
  spec.authors                = 'Victor S. Keenan'
  spec.email                  = 'me@victorkeenan.com'
  spec.files                  = ['lib/dnslookup.rb']
  spec.executables            = 'dnslookup'
  spec.required_ruby_version  = '>= 3.0'
  spec.homepage               = 'https://www.victorkeenan.com/projects/dnslookup/'
  spec.license                = 'MIT'
  spec.description            = "dnslookup is a DNS record query CLI gem written in Ruby. dnslookup automatically queries multiple public DNS servers or allows you to query a specific DNS server."
  spec.metadata               = {
    "bug_tracker_uri" => "https://github.com/VictorSK/dnslookup/issues/",
    "changelog_uri" => "https://github.com/VictorSK/dnslookup/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/github/kpumuk/meta-tags/",
    "homepage_uri" => "https://www.victorkeenan.com/projects/dnslookup/",
    "source_code_uri" => "https://github.com/VictorSK/dnslookup/",
    "rubygems_mfa_required" => "true"
  }
end
