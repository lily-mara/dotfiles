Scripts included
================

* [Git Checker](#git_checksh)
* [Tag Renamer](#rename_tagsh)
* [Commit .bash\_aliases](#commit_aliasessh)

git\_check.sh
-------------

Checks the status of all of your Git repos.

### Useage ###

Just run `git\_check.sh <git_dir>` where `<git_dir>` is a directory holding all of your git repos. You can use symlinks, and the script works fine. I reccomend aliasing this in your .bashrc or .bash\_aliases file just so you don't have to type the directory every time. For example, in my `.bash_aliases` file, I have the following line: 

`alias gitCheck='/home/nate/git/git_check/git_check.sh /home/nate/git/'`

This script will print nothing if all of the repos in the directory are both in sync with the origin repo, and in need of no commits. Otherwise, the script will print `[REPO] needs push/pull` or `[REPO] needs commit` for each repo that is flagged.

rename\_tag.sh
--------------

Changes the name of a git tag.

### Useage ###

Run `rename\_tag.sh <old> <new>` where `<old>` is the old tag, and `<new>` is the new tag.

commit\_aliases.sh
==================

Commits my .bash\_aliases file using the command-line argument as a commit message, then pushes it. I have `edita` aliased to open my .bash\_aliases file in Vim for editing, so I typically am not in the same folder as the file when I do this. This means that I am not in a position to easily commit my changes after an edit to this file, so I just made this script to more easily facilitate that.

gist\_commit.sh
===============

commits the current folder with a null commit message, as gists do not have commit messages.
