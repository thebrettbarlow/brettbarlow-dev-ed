# Brett Barlow's Salesforce Developer Org

![Salesforce CI](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-ci.yml/badge.svg)
[![Apex Code Coverage](https://codecov.io/gh/thebrettbarlow/brettbarlow-dev-ed/branch/main/graph/badge.svg?token=33XF1HO3VI&flag=apex)](https://codecov.io/gh/thebrettbarlow/brettbarlow-dev-ed)
[![LWC Code Coverage](https://codecov.io/gh/thebrettbarlow/brettbarlow-dev-ed/branch/main/graph/badge.svg?token=33XF1HO3VI&flag=lwc)](https://codecov.io/gh/thebrettbarlow/brettbarlow-dev-ed)

https://brettbarlow-dev-ed.my.site.com

This repo includes metadata for projects I work on in my Salesforce Developer Org.
Learn more about the projects
[here](https://brettbarlow-dev-ed.my.site.com/projects) and feel free to
[contact me](https://brettbarlow-dev-ed.my.site.com/contact) if you have questions.

## Build a Scratch Org

![Salesforce Scratch Org](https://github.com/thebrettbarlow/brettbarlow-dev-ed/actions/workflows/salesforce-scratch.yml/badge.svg)

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

The `test` job of [pr.yml](./.github/workflows/pr.yml) only runs LWC tests
because any modified Apex tests have not been deployed to the org yet. We
run Apex tests during the `validate-in-salesforce` job.
