# Changelog

## 0.1.1

### Fixed

* Returned exception was assumed to be a `String`, which is
  incorrect. So we return `Effect.Exception.Error` instead.

## 0.1.0

### Added

* Basic parsing function (`makeAddress`)
* Extraction of fields: `host`, `original`, `originalHost`, `user`
* Conversion to string: `address`, `toString`
* Tests
