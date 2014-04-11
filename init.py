#!/usr/bin/env python3
import os
import sys

files = [
		'aliases',
		'bashrc',
		'tmux.conf'
]


def main():
	parse_for_task()


def parse_for_task():
	arglist = sys.argv[1:]
	if 'link' in arglist:
		make_all_links()
		return
	if 'clean' in arglist:
		clean_all_links()
		return
	if 'relink' in arglist:
		clean_all_links()
		make_all_links()
		return
	make_all_links()


def clean_all_links():
	for file in files:
		if exists(file):
			os.remove(dotfile_path(file))


def make_all_links():
	dotfiles_dir = os.path.dirname(os.path.realpath(__file__))

	for file in files:
		if not exists(file):
			make_link(file)
		else:
			if safe_to_link(file):
				make_link(file)
			else:
				print('Skipping {0}...'.format(file))


def safe_to_link(file):
	path = dotfile_path(file)
	is_link = os.path.islink(path)
	if not is_link:
		delete = input('{0} exists, and is not a link, delete? (y/n)'.format(file))
		if delete.lower() == 'y':
			os.remove(path)
			return True
		return False
	delete = input('{0} exists, and is a link, delete? (y/n)'.format(file))
	if delete.lower() == 'y':
		os.remove(path)
		return True
	return False


def dotfile_path(file):
	dotfile = '.' + file
	home_path = os.path.expanduser('~')
	path = os.path.join(home_path, dotfile)
	path = os.path.abspath(path)
	return path


def exists(file):
	file_path = dotfile_path(file)
	dotfile_exists = os.path.exists(file_path)
	return dotfile_exists


def make_link(file):
	link_path = dotfile_path(file)
	file_path = os.path.abspath(file)
	os.symlink(file_path, link_path)
	print('Linking ./{0} to {1}...'.format(file, link_path))
	print()


if __name__ == '__main__':
	main()
