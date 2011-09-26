Create bi-directional cross-references in the comments between two different github issues.


### Usage

Example:

    $ ghi-xref -s bitly/bitly#123 -t bitly/bitly#456
    
You can also have multiple targets:

```
$ ghi-xref -s bitly/bitly#123 --target bitly/prototypes#456 bitly/prototypes#789 -m "For the win"
Linking bitly/bitly issue #123 to bitly/prototypes issue #456
   -> ghi -r bitly/bitly comment 123 -m "Cross referencing this issue with bitly/prototypes#456. For the win"
   -> ghi -r bitly/prototypes comment 456 -m "Cross referencing this issue with bitly/bitly#123. For the win"
Linking bitly/bitly issue #123 to bitly/prototypes issue #789
   -> ghi -r bitly/bitly comment 123 -m "Cross referencing this issue with bitly/prototypes#789. For the win"
   -> ghi -r bitly/prototypes comment 789 -m "Cross referencing this issue with bitly/bitly#123. For the win"
```

Fun

### Screenshots (why not?)

![screenshot](https://img.skitch.com/20110926-qw8mhm3gdt9rm3h4kta5a3pq91.png)

### Dependencies

This just pipes shit to the command line, so it requires [github-cli](https://github.com/jsmits/github-cli) package to be installed and properly configured.  

To get that, do `pip install -e git://github.com/jsmits/github-cli.git#egg=github-cli`