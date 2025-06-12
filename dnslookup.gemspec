# frozen_string_literal: true

require_relative "lib/dnslookup/version"

Gem::Specification.new do |spec|
  spec.name                   = 'dnslookup'
  spec.version                = DNSLookup::VERSION
  spec.authors                = ["Victor S. Keenan"]
  spec.email                  = ["me@victorkeenan.com"]

  spec.summary                = "A simple Ruby CLI tool for querying DNS records."
  spec.description            = "A Ruby CLI tool to query DNS records from multiple public or custom name servers, providing fast and flexible DNS lookups."
  spec.homepage               = 'https://www.victorkeenan.com/projects/dnslookup/'
  spec.license                = 'MIT'
  spec.required_ruby_version  = '>= 3.0'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/VictorSK/dnslookup/"
  spec.metadata["changelog_uri"] = "https://github.com/VictorSK/dnslookup/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/VictorSK/dnslookup/issues/"
  spec.metadata["documentation_uri"] = "https://github.com/VictorSK/dnslookup/blob/main/README.md"
  spec.metadata["rubygems_mfa_required"] = 'true'
  spec.files = Dir["lib/**/*.rb"]
  spec.executables            = 'dnslookup'
  # spec.require_paths          = ["lib"]
end
