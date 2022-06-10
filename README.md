# Brett Barlow's Salesforce Developer Org

![Salesforce CI](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-ci.yml/badge.svg)
![Salesforce Scratch Org](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-scratch.yml/badge.svg)

https://brettbarlow-dev-ed.my.site.com

This repo includes metadata for projects I work on in my Salesforce Developer Org. Feel free to [raise an issue](https://github.com/thebrettbarlow/brettbarlow-dev-ed/issues) or [contact me](https://brettbarlow-dev-ed.my.site.com/contact) if you have questions.

## Push to a Scratch Org

Following a pattern I saw in a few of the [trailheadapps](https://github.com/trailheadapps) repos, I added scripts to the repo's [bin](https://github.com/thebrettbarlow/brettbarlow-dev-ed/tree/main/bin) folder that can be used to make Scratch Orgs.

Clone this repo, `cd` into it and run this to make a Scratch Org:

```shell
./bin/install-scratch.sh
```

## Dev Dependencies

The following tools need to be installed in order to work with this project:

```
# Salesforce CLI: https://developer.salesforce.com/tools/sfdxcli
npm install sfdx-cli --global
npm install @salesforce/cli --global

# Salesforce Code Analyzer: https://forcedotcom.github.io/sfdx-scanner
sfdx plugins:install @salesforce/sfdx-scanner@latest-pilot
```

## Notes

check:apex:scripts is needed because we need to pass `--parser apex-anonymous`
when running prettier on anonymous apex.

Not running test:apex in the Test job because updated apex class files will not
be used in this test run. It will run tests in the org as they are. The validate-in-salesforce
step will run apex tests with any changes so we wait until then to run them.
