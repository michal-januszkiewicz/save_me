# SaveMe

SaveMe is a gem to store your data in an organized way. Let's say you have a script that saves the results in `results` file/folder and another run of this script (accidental or not) would overwrite your previous results. This is where SaveMe comes in. You put a one-liner in your code and your data is safe and organized.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'save_me'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install save_me

## Usage

Put this line in your code before you run your script
```ruby
SaveMe.call("path_to_what_you_want_to_copy", results_path: "./results", ymd: 0b110, params: { whatever: "you need here" })
```

First argument is a path to the file/folder you want to save.

Argument `results_path`(optional, default: "./") is a path to a folder where your results will be copied. If any directory in the path doesn't exist yet, it will be created by the gem.

Argument `ymd`(optional, default: `0b111`) is the folder structure. Notice it's in binary format. Each 1 or 0 corresponds to a letter in the `ymd`.
* `y` - year
* `m` - month
* `d` - day

A `1` creates a folder for a year/month/day, a `0` will put a year/month/day in the final folder name.

Examples:
* `0b111`
```ruby
SaveMe.call("results", results_path: "archive", ymd: 0b111, params: { test: "test" })
```
```
archive/
└── 2017
    └── 4
        └── 3
            └── 10:16:18
                ├── params.json
                └── results
                    └── results.json
```

* `0b110`
```ruby
SaveMe.call("results", results_path: "archive", ymd: 0b110, params: { test: "test" })
```
```
archive/
└── 2017
    └── 4
        └── 03_10:18:55
            ├── params.json
            └── results
                └── results.json
```

Argument `params`(optional, default: `nil`) will be saved as json file with your results so you don't need to remember what params were used to get those particular results.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michal-januszkiewicz/save_me.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
