[![Gem Version](https://badge.fury.io/rb/dnslookup.svg)](https://badge.fury.io/rb/dnslookup)

# dnslookup

dnslookup is a DNS record query CLI gem written in Ruby. dnslookup automatically queries multiple public DNS servers or allows you to query a specific DNS server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dnslookup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dnslookup

## Usage

Lookup DNS records:
```bash
$ dnslookup <domain name> [options]
```
##### Options:
  `-m` or `--mx` will return only MX records.

  `-a` or `--aname` will return only A name records.

  `-c` or `--cname` will return only C name records.

  `-t` or `--txt` will return only TXT records.

  `-s` or `--server=IP` will query specific name server IP.

  `-h` or `--help` will output this help in your shell.

Help with usage and options:
```bash
$ dnslookup -h
```
## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/VictorSK/dnslookup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Crafted With Love
Coded crafted by me, [Victor S. Keenan](http://www.victorkeenan.com). Find me on Twitter [@VictorSK](https://twitter.com/victorsk).
