#!/bin/zsh

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

# Step 0: Create a directory
mkdir "$1"

# Step 1: Copy in the necessary files
DIR="$(dirname "$(readlink -f "$0")")"

cp $DIR/tsconfig.json $1/
cp $DIR/.mocharc.json $1/

# Step 2: Change to the newly created directory
cd "$1" || exit 1

# Step 3: Create a new git repository
git init
curl -sL https://www.toptal.com/developers/gitignore/api/macos,vim,node,git >> .gitignore
git add .gitignore
git commit -m"Add .gitignore"

# Step 4a: Create a directory and file for Javascript tests
mkdir tests
touch tests/$1_test.ts

# Step 4b: Populate the Javascript test file
cat > tests/$1_test.ts <<- BOILERPLATE
import $1 from "../src/$1"

var expect = require('chai').expect;

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

# Step 5a: Create a directory and file for Javascript source
mkdir src
touch src/$1.ts

# Step 5b: Populate the Javascript source file
cat > src/$1.ts <<- BOILERPLATE
export default function $1(replace_me_argument: string): string {
    return 'REPLACE ME';
};
BOILERPLATE

# Step 5: Add mocha and chai as dependencies using npm
npm init -y
npm install chai mocha ts-node cross-env @types/chai @types/mocha --save-dev

# Step 6: Update the npm test script to run Mocha with the test file
echo "{
  \"scripts\": {
    \"test\": \"mocha $1.ts\"
  }
}" > package.json

# Step 6: Start an observer for file changes
npm install -g onchange

# Provide user instructions
echo "Project setup complete! Watching for file changes..."

# Create a script to run npm test on file changes
onchange "src/$1.ts" "tests/$1_test.ts" -- npm test

