#!/usr/bin/env python3
import os
import sys
import subprocess

files = [
		'aliases',
		'bashrc',
		'tmux.conf',
		'conkyrc'
]

tasks = {
		'link': 'create symlinks for dotfiles in this folder',
		'clean': 'remove symlinks for dotfiles in this folder',
		'relink': 'remove and then create symlinks for files in this folder',
		'vim': 'download and link vim config from github'
		}


def main():
	print()
	print('relaunch as ./init.py [task]')
	print()
	print('{0:10}{1:30}'.format('Task', 'Description'))
	print('-' * 9 + ' ' + '-' * 29)
	for task, description in tasks.items():
		print('{0:10}{1:30}'.format(task, description))
	print()


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
	if 'vim' in arglist:
		git_vim()
		return
	make_all_links()


def git_vim():
	homepath = os.path.expanduser('~')
	vimpath = os.path.join(home_path, '.vim')
	vimrc_path = os.path.join(vimpath, '.vimrc')
	vimrc_link_path = os.path.join(home_path, '.vimrc')
	if not os.path.exists(vimpath):
		subprocess.call(['git', 'clone', 'ssh://git@github.com/natemara/vimfiles', vimpath])
		os.symlink(vimrc_path, vimrc_link_path)
	else:
		delete = input('{0} already exists, overwrite? (y/n) '.format(vimpath))
		if delete.lower() == 'y':
			os.remove(vimpath)
			git_vim()



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
			print('Skipping {0}...'.format(file))


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
