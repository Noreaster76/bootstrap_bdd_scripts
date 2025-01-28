#!/bin/sh

# create and cd into the directory
mkdir $1
cd $1

# set up git
if [ ! -f .gitignore ]
then
    git init
    curl -sL https://www.toptal.com/developers/gitignore/api/macos,ruby,vim,git >> .gitignore
    git add .gitignore
    git commit -m"Add .gitignore"
fi

# create the ruby file
if [ ! -f $1.rb ]
then
    touch $1.rb
fi

cat > $1.rb <<- BOILERPLATE
def $1(input)
end

RSpec.describe '#$1' do

  {
  }.each do |input, expected_output|
    context "with an input of #{input}" do
      it { expect($1(input)).to eq expected_output }
    end
  end

end
BOILERPLATE

# set up ruby gems
if [ ! -f Gemfile ]
then
    bundle init
    echo "gem 'debug', '>= 1.0.0'" >> Gemfile
    echo "gem 'rspec'" >> Gemfile
    echo "gem 'observr'" >> Gemfile
    echo "gem 'observer'" >> Gemfile
    bundle

    git add Gemfile
    git add Gemfile.lock
    git commit -m"Add Gemfile and Gemfile.lock"
fi

# set up observr
if [ ! -f Observrfile ]
then
    touch Observrfile
    echo "watch( '$1.rb' ) { |md| system(\"clear && bundle exec rspec --fail-fast #{md[0]}\") }" >> Observrfile

    git add Observrfile
    git commit -m"Add Observrfile"
fi

# start observing
echo "Observr is now watching $1.rb"
bundle exec observr Observrfile

