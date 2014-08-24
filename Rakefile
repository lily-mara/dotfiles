#
# Copied asis (for now) from holman dotfiles:
# https://github.com/holman/dotfiles

require 'rake'

dotfiles_dir = File.expand_path(File.dirname(__FILE__))

desc "Hook our dotfiles into system-standard positions."
task :install do
  # make_links
  git_config
end

def git_config
  ignore_file = File.join dotfiles_dir 'gitignore_global'
  config_file = File.join dotfiles_dir 'gitconfig'
  sh "git config --global core.excludesfile #{ignore_file}"
  sh "git config --global include.path #{config_file}"
end

def make_links
  linkables = Dir.glob('**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup.#{Time.now.strftime("%Y-%m-%d")}"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

task :clean do

  Dir.glob('*.symlink').each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end
    
    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end

  end
end

task :default => 'install'
