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

cp $DIR/pom.xml $1/
cp -r $DIR/src $1/

# Step 2: Change to the newly created directory
cd "$1" || exit 1

# Step 3: Create a new git repository
git init
curl -sL https://www.toptal.com/developers/gitignore/api/macos,vim,java,git >> .gitignore
git add .gitignore
git commit -m"Add .gitignore"

# Step 4: Open the IDE
/Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS/idea pom.xml

