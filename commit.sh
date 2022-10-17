#!/bin/bash


git status
git add .
msg="update document"
msg=$1
git config --global user.email "rockman88v@gmail.com"
git config --global user.name "rockman88v"
git remote set-url origin https://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@github.com/rockman88v/kubernetes_basic_course.git
git commit -m "$msg"
 git push -u origin master

