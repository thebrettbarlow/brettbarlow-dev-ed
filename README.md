# Brett Barlow's Salesforce Developer Org

![Salesforce CI](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce.yml/badge.svg)

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
# Salesforce Code Analyzer: https://forcedotcom.github.io/sfdx-scanner
sfdx plugins:install @salesforce/sfdx-scanner@latest-pilot
```
