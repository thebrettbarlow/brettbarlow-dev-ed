# Brett Barlow's Salesforce Developer Org

![Salesforce CI](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-ci.yml/badge.svg)

https://brettbarlow-dev-ed.my.site.com

This repo includes metadata for projects I work on in my Salesforce Developer Org. Feel free to [raise an issue](https://github.com/thebrettbarlow/brettbarlow-dev-ed/issues) or [contact me](https://brettbarlow-dev-ed.my.site.com/contact) if you have questions.

## Build a Scratch Org

![Salesforce Scratch Org](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-scratch.yml/badge.svg)

To build a Scratch Org from this project:

#### 1. Clone the repo and `cd` into it:

```shell
git clone https://github.com/thebrettbarlow/brettbarlow-dev-ed.git
cd brettbarlow-dev-ed
```

#### 2. Set a Default DevHub

```shell
sfdx force:config:set defaultdevhubusername=your_devhub
```

#### 3. Build the Scratch Org

```shell
./scripts/build_scratch_org.sh
```

## Dev Dependencies

These are required to work with this project:

```shell
# Salesforce CLI: https://developer.salesforce.com/tools/sfdxcli
npm install sfdx-cli --global
npm install @salesforce/cli --global
```

This is required to run `npm run lint:*` commands:

```shell
# Salesforce Code Analyzer: https://forcedotcom.github.io/sfdx-scanner
sfdx plugins:install @salesforce/sfdx-scanner@latest-pilot
```

## General Notes

#### Prettier

Anonymous Apex files end in `.apex` and `prettier-plugin-apex` needs the
`--parser apex-anonymous` when parsing these. This is why there are `*:apex:scripts`
commands and a specific `lint-staged` rule.

#### Running Tests for Pull Requests

The `Test` job of [pr.yml](./.github/workflows/pr.yml) runs LWC tests, but does not
run Apex tests because they have not been deployed to the org yet. We run Apex tests
during the `validate-in-salesforce` job.
