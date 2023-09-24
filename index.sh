#!/usr/bin/env sh

_() {
  YEAR="2003"
  echo "GitHub Username: "
  read -r USERNAME
  echo "GitHub Access token: "
  read -r ACCESS_TOKEN

  [ -z "$USERNAME" ] && exit 1
  [ -z "$ACCESS_TOKEN" ] && exit 1  
  [ ! -d $YEAR ] && mkdir $YEAR

  cd "${YEAR}" || exit
  git init
  echo "**${YEAR}**" \
    >README.md
  git add .
  GIT_AUTHOR_DATE="${YEAR}-08-30T18:00:00" \
    GIT_COMMITTER_DATE="${YEAR}-08-30T18:00:00" \
    git commit -m "${YEAR}"
  git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${YEAR}.git"
  git branch -M main
  git push -u origin main -f
  cd ..
  rm -rf "${YEAR}"

  echo
  echo "Cool, check your profile now: https://github.com/${USERNAME}"
} && _

unset -f _