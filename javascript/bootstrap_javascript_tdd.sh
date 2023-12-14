#!/bin/zsh

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

# Step 1: Create a directory
mkdir "$1"

# Step 2: Change to the newly created directory
cd "$1" || exit 1

# Step 3: Create a new git repository
git init
curl -sL https://www.toptal.com/developers/gitignore/api/macos,vim,node,git >> .gitignore
git add .gitignore
git commit -m"Add .gitignore"

# Step 4: Create a file for Javascript tests and source code
touch $1.js

# Add some example code to $1.js
cat > $1.js <<- BOILERPLATE
var expect = require('chai').expect;

var $1 = function (replace_me_argument) {
    return 'REPLACE ME';
};

describe('$1())', function() {
    const tests = [
        {
            args: 'replace_me_argument_0',
            expected: 'replace_me_expected_0'
        },
        {
            args: 'replace_me_argument_1',
            expected: 'replace_me_expected_1'
        }
    ];

    tests.forEach(({args, expected}) => {

        describe(\`when the input is \${args}\`, function () {
            it(\`returns \${expected}\`, function() {
                expect($1(args)).to.equal(expected);
            });
        });

    });
});
BOILERPLATE

# Step 5: Add mocha and chai as dependencies using npm
npm init -y
npm install --save-dev mocha chai

# Step 6: Update the npm test script to run Mocha with the test file
echo "{
  \"scripts\": {
    \"test\": \"mocha $1.js\"
  }
}" > package.json

# Step 6: Start an observer for file changes
npm install -g onchange

# Provide user instructions
echo "Project setup complete! Watching for file changes..."

# Create a script to run npm test on file changes
onchange "$1.js" -- npm test

