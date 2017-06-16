# DateRanger

DateRanger class for determining date ranges for dates pulled out of museum collections. The [list of date formats](https://gist.github.com/george08/4a115d95137827829e1419fcb5c0bd99) this class can parse is maintained by [george08](https://github.com/george08).

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
