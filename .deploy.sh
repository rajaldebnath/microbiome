#!/bin/bash
# See https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db

#set -o errexit # put back
SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

# Save some useful information
#SHA=`git rev-parse --verify HEAD`
GH_REPO="@github.com/microbiome/microbiome.git"
FULL_REPO="https://$GH_TOKEN$GH_REPO"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
#if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
#    echo "Skipping deploy; just doing a build."
#    doCompile
#    exit 0
#fi

rm -rf public # ; || exit 0;
mkdir public

# config
git config --global user.email "nobody@nobody.org"
git config --global user.name "Travis CI"

#for files in '*.tar.gz'; do
#        tar xfz $files
#done
tar -zxvf *.tar.gz

# Deploy
cd public
git init

# Create vignettes
# Then copy the newly created vignettes here
# R CMD BATCH ../vignettes/build.R
#cp ../inst/doc/*.html .
cp ../microbiome/inst/doc/*.html .
ls ../microbiome/ > files2.txt
ls ../ > files3.txt

# Add to git and deploy
git add *.html
git add files*.txt
git commit -a -m "Deploy to Github Pages"
git push --force --quiet $FULL_REPO $SOURCE_BRANCH:$TARGET_BRANCH # > /dev/null 2>&1
#git push --force --quiet $FULL_REPO master:gh-pages # > /dev/null 2>&1

# build (CHANGE THIS)
# Can add separate vignette build here later
#function doCompile {
#  ./compile.sh
#}
# Run our compile script -> Add this to a suitable place
# doCompile
#

#for files in '../microbiome/vignettes/*.html'; do    
#        cp $files .
#done



