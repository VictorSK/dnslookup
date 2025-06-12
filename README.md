# dnslookup — A simple Ruby CLI tool for querying DNS records

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Ruby](https://img.shields.io/badge/ruby-%3E%3D3.0-red)
[![Issues](https://img.shields.io/github/issues/VictorSK/dnslookup)](https://github.com/VictorSK/dnslookup/issues)
[![Last Commit](https://img.shields.io/github/last-commit/VictorSK/dnslookup)](https://github.com/VictorSK/dnslookup/commits/main)
[![Gem Version](https://badge.fury.io/rb/dnslookup.svg)](https://badge.fury.io/rb/dnslookup)

**dnslookup** is the fast, flexible, and developer-friendly Ruby CLI tool for DNS lookups. Effortlessly query A, MX, CNAME, and TXT records from multiple public or custom name servers... all with a single command. Whether you’re debugging, building, or just curious, dnslookup gives you the answers you need, right from your terminal.

- 🚀 **Lightning-fast DNS queries**
- 🌍 **Query multiple or custom DNS servers**
- 🛠️ **Simple, intuitive CLI interface**
- 💎 **Built for Ruby developers and sysadmins**

Take control of your DNS troubleshooting and exploration with dnslookup—the essential tool for anyone who works with domains.

Please use [GitHub Issues](https://github.com/VictorSK/dnslookup/issues) to report bugs.

## Installation

To add dnslookup to an existing project, add this line to your project's Gemfile:

```ruby
gem 'dnslookup'
```

And then execute:

```bash
bundle install
```

Or to install locally:

```bash
gem install dnslookup
```

## Usage

Lookup DNS records for a domain:

```bash
dnslookup example.com -a
```

### Options

| Option              | Description                     |
| ------------------- | ------------------------------- |
| `-m`, `--mx`        | Return only MX records          |
| `-a`, `--aname`     | Return only A records           |
| `-c`, `--cname`     | Return only CNAME records       |
| `-t`, `--txt`       | Return only TXT records         |
| `-s`, `--server=IP` | Query a specific name server IP |
| `-h`, `--help`      | Show help message               |

Help with usage and options:

```bash
dnslookup -h
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/VictorSK/dnslookup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the terms specified in the [CODE OF CONDUCT](CODE_OF_CONDUCT). It's code, let's be safe and have fun!

## License

dnslookup is copyright © 2016-2025 Victor S. Keenan. It is free software and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.

## Coded With Love

Code crafted by me, [Victor S. Keenan](https://www.victorkeenan.com). Find me on Twitter [@VictorSK](https://twitter.com/victorsk) or [hire me](https://www.inspyre.com) to design, develop, and grow your product or service.
