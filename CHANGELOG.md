# CHANGELOG

Noteworthy updates for each DNSLookup version are included here. For a complete changelog, see the git history.

## [0.4.0] - 2026-03-31

### Changed

- Fixed `-h` and `-v` so they work without requiring a domain argument
- Made the default lookup explicit by querying `A` records when no type flag is provided
- Improved security for safer argv-based call and report failed lookups separately from empty results
- Corrected `CNAME` queries
- Separated CLI argument parsing from query execution
- Refreshed the CLI documentation, tightened gem packaging metadata, and made the test suite deterministic
- Updated documentation to clarify installation requirements
- Expanded usage examples for default lookups

## [0.3.1] - 2025-06-13

### Changes

- General cleanup and maintenance

## [0.3.0] - 2025-06-12

### Changes

- Refactor gem source
- Refactor tests
- General cleanup and maintenance

## [0.2.0] - 2024-02-08

### New Features

- Added ability to check multiple record types at once.
- Updated core gem Ruby code and general code improvements.
- Updated tests.

## [0.1.6] - 2023-02-06

### Changes

- Added Ruby 3.0 to required versions.
- Spec bumps and general code improvements.

## [0.1.0] - 2016-02-01

### New Features

- Initial release
