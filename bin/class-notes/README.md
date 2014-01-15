Class Notes
===========

Just a simple script for note-taking during class. Specifically, notes
taken in Markdown under revision control with GitHub or BitBucket. I know
that that sounds like a very small minority of people, but I really just
make this script for me, I didn't really have any intent of releasing it.

I use this for notetaking in my coding classses, so that I have a directory
for each day, notes that show up by default, and version control for all of
the coding that is done in class.

What Does it Do?
----------------

This script does the following:

1. Today's date (in [ISO 8061](https://en.wikipedia.org/wiki/ISO_8601) format) is stored in a variable
2. A directory with the date as the title is created and changed into
3. Today's date is added to the top of a README.md file (this is so that GitHub will show it by default)
4. A line of `=` is added below the date so that the date will be a heading
5. Two blank lines are added
6. Vim (the one true editor) is started, at the last line, in insert mode, ready to take notes for the day
