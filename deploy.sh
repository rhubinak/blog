#!/bin/bash
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Optimize CSS
purifycss public/css/style.css public/index.html public/404.html public/tags/index.html public/tags/page/1/index.html public/posts/index.html public/posts/page/1/index.html public/posts/the_reason_for_this_blog/index.html public/posts/how_to_establish_a_llc_in_czech_republic/index.html public/page/1/index.html --min --info --out public/css/style.css

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..
