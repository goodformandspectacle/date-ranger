# DateRanger

DateRanger Ruby class used for determining date ranges for dates pulled out of museum collections. The [list of date formats](https://gist.github.com/george08/4a115d95137827829e1419fcb5c0bd99) this class can parse is maintained by [george08](https://github.com/george08).

## Usage

Add to your project both the `date_ranger.rb` and `bounds.rb` files. You can find them in the `lib` directory.

Include DateRanger in the file where you intend to use it:

```ruby
require './date_ranger'
```

Parsing dates looks like this:
```ruby
DateRanger.new('c. 1995').parse
```

Which returns a hash of range bounds:
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
