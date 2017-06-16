# DateRanger

DateRanger Ruby class used for determining date ranges for dates pulled out of museum collections. The [list of date formats](https://gist.github.com/george08/4a115d95137827829e1419fcb5c0bd99) this class can parse is maintained by [george08](https://github.com/george08).

## Why

Most dates attached to collection object express a range of dates, but the [formats used](https://gist.github.com/george08/4a115d95137827829e1419fcb5c0bd99) vary. In order to allow a more standardised way of storing those date ranges we need to parse them into a more reusable format.

This library parses the common date formats and decides what they mean. Some ranges are expressed as a single date (eg. '1990s'), others as a range ('Jan-Mar 1985'), and yet others are very precise ('23 Jun 1945'). The library provides the information about the start and end of the range.

## Usage

Add to your project both the `date_ranger.rb` and `bounds.rb` files. You can find them in the `lib` directory.

Include DateRanger in the file where you intend to use it:

```ruby
require './date_ranger'
```

The library accepts date input as a string. Parsing dates looks like this:
```ruby
DateRanger.new('c. 1995').parse
```

Which returns a hash of range bounds, expressed as Date objects:
```ruby
{:start_date=>#<Date: 1995-01-01 ((2449719j,0s,0n),+0s,2299161j)>, :end_date=>#<Date: 1995-12-31 ((2450083j,0s,0n),+0s,2299161j)>}
```

### Dependencies

DateRanger requires only the Ruby standard library.

## Contributing

### Running tests

First, install the required gems:

```
bundle install
```

And then run tests:

```
rspec -f d
```

### Writing new specs

Add your tests to `spec/date_range_spec.rb`

### Updating the library

Check the `lib` directory for the relevant files. You will find the DateRanger class in the `lib/date_ranger.rb`, which required a module from `lib/bounds.rb`.
