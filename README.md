# dnslookup — A simple Ruby CLI tool for querying DNS records

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Ruby](https://img.shields.io/badge/ruby-%3E%3D3.0-red)
[![Issues](https://img.shields.io/github/issues/VictorSK/dnslookup)](https://github.com/VictorSK/dnslookup/issues)
[![Last Commit](https://img.shields.io/github/last-commit/VictorSK/dnslookup)](https://github.com/VictorSK/dnslookup/commits/main)
[![Gem Version](https://badge.fury.io/rb/dnslookup.svg)](https://badge.fury.io/rb/dnslookup)

**dnslookup** is a Ruby CLI for querying A, MX, CNAME, and TXT records from default or custom DNS servers. It wraps `dig` with a small command-line interface that is useful for quick troubleshooting, scripting, and day-to-day DNS checks.

Please use [GitHub Issues](https://github.com/VictorSK/dnslookup/issues) to report bugs.

## Requirements

- Ruby 3.0 or newer
- The `dig` executable available on your `PATH`

If `dig` is not already installed, common package names are:

```bash
brew install bind
```

```bash
sudo apt-get install dnsutils
```

## Installation

To add dnslookup to an existing project, add this line to your project's Gemfile:

```ruby
gem 'dnslookup'
```

And then execute:

```bash
bundle install
```

Or to install the CLI locally:

```bash
gem install dnslookup
```

## Usage

Lookup DNS records for a domain:

```bash
dnslookup example.com -a
```

If you omit a record-type option, `dnslookup` queries `A` records by default:

```bash
dnslookup example.com
```

By default, `dnslookup` queries Google's public resolvers: `8.8.8.8` and `8.8.4.4`. Use `-s` to query a specific resolver.

### Options

| Option              | Description                          |
| ------------------- | ------------------------------------ |
| `-m`, `--mx`        | Return only MX records               |
| `-a`, `--aname`     | Return only A records                |
| `-c`, `--cname`     | Return only CNAME records            |
| `-t`, `--txt`       | Return only TXT records              |
| `-A`, `--all`       | Return A, MX, CNAME, and TXT records |
| `-s`, `--server=IP` | Query a specific name server IP      |
| `-h`, `--help`      | Show help message                    |
| `-v`, `--version`   | Show gem version                     |

### Examples

Lookup the default `A` record:

```bash
dnslookup example.com
```

Lookup a `CNAME` record explicitly:

```bash
dnslookup ftp.victorkeenan.com -c
```

Query a specific name server:

```bash
dnslookup example.com -a -s1.1.1.1
```

Query all supported record types at once:

```bash
dnslookup example.com --all
```

If `dig` cannot complete the lookup, `dnslookup` reports the query as failed instead of showing an empty result:

```bash
dnslookup example.com -a -s203.0.113.53
```

Depending on the failure, the output will include either `(query failed)` or `(query failed: ...)`.

Help with usage and options:

```bash
dnslookup -h
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/VictorSK/dnslookup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the terms specified in the [CODE OF CONDUCT](CODE_OF_CONDUCT.md).

## License

dnslookup is copyright © 2016-2026 Victor S. Keenan. It is free software and may be redistributed under the terms specified in the [LICENSE](LICENSE.txt) file.

## Coded With Love

Code crafted by me, [Victor S. Keenan](https://www.victorkeenan.com). Find me on Twitter [@VictorSK](https://twitter.com/victorsk) or [hire me](https://www.inspyre.com) to design, develop, and grow your product or service.
