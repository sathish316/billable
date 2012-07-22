## Billable

Billable is a command line utility to automatically fill timesheets using git logs and mechanize. This is only for lazy developers.

It greps git logs having your name in commit message. It filters logs between last monday and last friday and fills your timesheet using mechanize.

Billable uses profiles for different organizations. Currently it works for TW. To add your organization fork this repo and add settings/steps specific to your organization. This requires some generalization in code.

### Usage

To install billable:

```
$ git clone *repo*
$ bundle install
$ rake install
```

To see all available options

```
$ bill --help
```

Example usage (with default dates between last monday and last friday):

```
$ cd project-repo

$ bill -a AUTHOR -u TIME_USERNAME -s TIME_PASSWORD -c PROJECT_CODE

$ bill -a John -u john123 -s password123 -c "AREA 51"

```

You can customize from date, to date and billed hours:

```
$ bill -a John -u john123 -s password123 -c "AREA 51" -f 7/1/2012 -t 7/5/2012 -h 9
```
### Assumptions

It makes the following assumptions:

* It works only for git
* Your name is present in git commit message
* You always fill timesheets the next week

### TODO

1. DONE: Fill timesheet with RSA Login
2. DONE: Fill timesheet with username/password
3. TODO: Fill timesheet without Login
4. TODO: Include log entries which don't have author name in commit message