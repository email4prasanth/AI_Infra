- Allows you to keep your global identity for other work projects
```sh
git config --global user.name "Marri Prasanth"
git config --global user.email "mprasanth@inlogic.in"
git config --global --list
git commit --amend --reset-author --no-edit
git push origin dev
```
- Run these commands to apply profile to specific repository, prioritises local settings over global settings during commits
```sh
git config --local user.name "email4prasanth"
git config --local user.email "email4prasanth@gmail.com"
git config --local --list
git config user.name; git config user.email
```