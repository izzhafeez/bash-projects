#!/bin/bash

cd Documents
ls

read -p "Enter filepath from Documents: " filepath
read -p "Enter commit message: " message

function do_git() {
  git add $1
  git commit -m "Edit $(basename $1): $message"
}

function loop_through_folder () {
  echo "Depth: $2"
  if [[ $2 > 3 ]]
  then
    do_git $1 
  else
    for FILES in "$1/*"
    do
      echo "Files: $FILES"
      for FILE in $FILES
      do
        echo "File: $FILE"
        if [[ -d $FILE ]]
        then
          i=$(($2+1))
          loop_through_folder $FILE $i
        else
          do_git $FILE
        fi
      done
    done
  fi
}

cd $filepath

loop_through_folder . 0

for FILES in "*"
do
  for FILE in $FILES
  do
    do_git $FILE
  done
done

git push
