## Billable

Billable is a command line utility to automatically fill timesheets using git logs and mechanize. This is only for lazy developers.

It greps git logs having your name in either author or commit message. It filters logs between last monday and last friday and fills your timesheet using mechanize.

Billable uses profiles for different organizations. Currently it works for TW. To add your organization fork this repo and add settings/steps specific to your organization. This requires some generalization in code.

### Usage

To install billable:

```
$ git clone *repo*

$ rake install
```

To see all available options

```
$ bill --help
```

Example usage (with default dates):

```
$ cd project-repo

$ bill -a AUTHOR -u TIME_USERNAME -s TIME_PASSWORD -c PROJECT_CODE

$ bill -a John -u john123 -s password123 -c "AREA 51"

```

You can customize from date, to date and billed hours:

```
$ bill -a John -u john123 -s password123 -c "AREA 51" -f 7/1/2012 -t 7/5/2012 -h 9
```

### TODO

# Currently works with Login
# TODO: Fill timesheet without Login