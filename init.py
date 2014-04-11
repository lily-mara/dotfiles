#!/usr/bin/env python3
import os


def main():
	dotfiles_dir = os.path.dirname(os.path.realpath(__file__))

	files = [
				'aliases',
				'bashrc',
				'tmux.conf'
			]

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
	is_link = os.path.islink(dotfile_path)
	if not is_link:
		delete = input('{0} exists, and is not a link, delete? (y/n)'.format(file))
		if delete.lower() == 'y':
			os.remove(dotfile_path)
			return True
		return False
	delete = input('{0} exists, and is a link, delete? (y/n)'.format(file))
	if delete.lower() == 'y':
		os.remove(dotfile_path)
		return True
	return False


def dotfile_path(file):
	dotfile = '.' + file
	home_path = os.path.expanduser('~')
	path = os.path.join(home_path, dotfile)
	return path


def exists(file):
	file_path = dotfile_path(file)
	file_path = os.path.abspath(file_path)
	print("'{0}'".format(file_path))
	print(type(file_path))
	dotfile_exists = os.path.exists(file_path)
	print(dotfile_exists)
	return dotfile_exists


def make_link(file):
	path = dotfile_path(file)
	


if __name__ == '__main__':
	main()
