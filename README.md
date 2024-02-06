# dnslookup

[![Gem Version](https://badge.fury.io/rb/dnslookup.svg)](https://badge.fury.io/rb/dnslookup)

dnslookup is a DNS record query CLI gem written in Ruby. dnslookup automatically queries multiple public DNS servers or allows you to query a specific DNS server.

Please use [GitHub Issues](https://github.com/VictorSK/dnslookup/issues) to report bugs.

## Installation

To add dnslookup to an existing project, add this line to your projects's Gemfile:

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

Lookup DNS records:

```bash
dnslookup <domain name> [options]
```

### Options

`-m` or `--mx` will return only MX records.

`-a` or `--aname` will return only A name records.

`-c` or `--cname` will return only C name records.

`-t` or `--txt` will return only TXT records.

`-s` or `--server=IP` will query specific name server IP.

`-h` or `--help` will output this help in your shell.

Help with usage and options:

```bash
dnslookup -h
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/VictorSK/dnslookup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the terms specified in the [CODE OF CONDUCT](CODE_OF_CONDUCT). It's code, lets be safe and have fun!

## License

dnslookup is copyright © 2016-2024 Victor S. Keenan. It is free software and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.

## Coded With Love

Coded crafted by me, [Victor S. Keenan](https://www.victorkeenan.com). Find me on Twitter [@VictorSK](https://twitter.com/victorsk) or [hire me](https://www.inspyre.com) to design, develop, and grow your product or service.
