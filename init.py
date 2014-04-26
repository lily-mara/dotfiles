#!/usr/bin/env python3
import os
import sys
import subprocess
import shutil

files = [
		'aliases',
		'bashrc',
		'tmux.conf',
		'conkyrc',
		'zshrc',
		'zpreztorc'
]

tasks = {
		'link': 'create symlinks for dotfiles in this folder',
		'clean': 'remove symlinks for dotfiles in this folder',
		'relink': 'remove and then create symlinks for files in this folder',
		'vim': 'download and link vim config from github',
		'git_config': 'setup the global git configuration (name, email, ignore)',
		'all': 'do all of the tasks for setting up a new computer, in order'
		}

dotfiles_dir = os.path.dirname(os.path.realpath(__file__))


def main():
	if len(sys.argv) == 1:
		print_tasks()
	else:
		parse_for_task()


def print_tasks():
	print()
	print('relaunch as ./init.py [task]')
	print()
	print('{0:10}{1}'.format('Task', 'Description'))
	print('-' * 9 + ' ' + '-' * 19)
	for task, description in tasks.items():
		print('{0:10}{1}'.format(task, description))
	print()


def parse_for_task():
	arglist = sys.argv[1:]
	for i in arglist:
		if i not in tasks.keys():
			print('invalid command-line argument')
			sys.exit(0)
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
	if 'git_config' in arglist:
		git_config()
		return
	if 'all' in arglist:
		make_all_links()
		git_config()
		git_vim()
		return
	make_all_links()


def git_vim():
	home_path = os.path.expanduser('~')
	vimpath = os.path.join(home_path, '.vim')
	vimrc_path = os.path.join(vimpath, '.vimrc')
	vimrc_link_path = os.path.join(home_path, '.vimrc')
	bundle_path = os.path.join(vimpath, 'bundle')
	vundle_path = os.path.join(bundle_path, 'vundle')
	if not os.path.exists(vimpath):
		subprocess.call(['git', 'clone', 'ssh://git@github.com/natemara/vimfiles', vimpath])
		os.symlink(vimrc_path, vimrc_link_path)
		os.mkdir(bundle_path)
		subprocess.call(['git', 'clone', 'https://github.com/gmarik/vundle', vundle_path])
		subprocess.call(['vim', '-c', 'BundleInstall'])
	else:
		delete = input('{0} already exists, overwrite? (y/n) '.format(vimpath))
		if delete.lower() == 'y':
			shutil.rmtree(vimpath)
			try:
				os.remove(vimrc_link_path)
			except:
				pass
			git_vim()



def clean_all_links():
	for file in files:
		if exists(file):
			os.remove(dotfile_path(file))


def make_all_links():
	for file in files:
		if not exists(file):
			make_link(file)
		else:
			print('Skipping {0}...'.format(file))


def git_config():
	ignore_file = os.path.join(dotfiles_dir, 'gitignore_global')
	ignore_file = os.path.join(dotfiles_dir, 'gitconfig')
	subprocess.call(['git', 'config', '--global', 'core.excludesfile', ignore_file])
	subprocess.call(['git', 'config', '--global', 'include.path', config_file])


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
