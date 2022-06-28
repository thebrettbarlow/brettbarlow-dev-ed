const { jestConfig } = require('@salesforce/sfdx-lwc-jest/config');

// eslint-disable-next-line no-undef
module.exports = {
    ...jestConfig,
    modulePathIgnorePatterns: ['<rootDir>/.localdevserver']
};
