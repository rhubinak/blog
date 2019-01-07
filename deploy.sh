#!/bin/bash
#echo -e "\033[0;32mSpellcheck\033[0m"
#hunspell -d en_US content/posts/*.md

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Optimize CSS
purgecss --css themes/kiss/static/css/style.css --content public/*.html public/**/*.html public/**/**/*.html public/**/**/**/*.html --out public/css/style.min.css

# Optimize other stuff
minify -r -o public/ public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -S -m "$msg"

git push origin master

#git@github.com:rhubinak/dotfiles.git

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -S -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..
