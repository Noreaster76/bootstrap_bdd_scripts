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
sed -i '' "s/bdd_skeleton/$1/g" $1/pom.xml
cp -r $DIR/src $1/

# Step 2: Change to the newly created directory
cd "$1" || exit 1

# Step 3: Create a new git repository
git init
cp $DIR/.gitignore .
git add .gitignore
git commit -m"Add .gitignore"

# Step 4: Commit the Maven POM
git add pom.xml
git commit -m"Add Maven POM"

# Step 5: Open the IDE

open .
echo "Script complete. Open your IDE and create a new project from $1/pom.xml."

