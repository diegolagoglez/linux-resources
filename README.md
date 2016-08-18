# Linux Resources #

## Introduction ##

This project has all my Linux resources (tools, scripts, configuration files…) to personalize my environment, which includes:

* `bashrc.d`: BASH configuration files.
* `bin`: Binary tools and scripts.
* `rc`: Linux console configuration files.
* `sublime-text`: Sublime Text configuration and customization files.

Project main repository is at: https://github.com/diegolagoglez/linux-resources.git 

## Tools Installation ##

Make a link into your home directory to the binary tools directory. Example:

```bash
user@host:~:$ pwd
/home/user
user@host:~:$ ln -s ~/projects/linux-resources/bin
```

Insert, if needed, your home bin path into PATH environment variable:

```bash
export PATH=$PATH:~/bin
```

## Environment Installation ##

Copy files and symlinks from `~/projects/linux-resources/bashrc.d` to any directory you want (I prefer put them into `~/.bashrc.d/`) or link that directory into home with:

```bash
user@host:~:$ ln -s ~/projects/linux-resources/bashrc.d .bashrc.d
```

Then, add the following lines into `~/.bashrc` (sourcing only sorted symbolic links to ensure precedence):

```bash
if [ -d ~/.bashrc.d/ ]; then
  for file in $(find ~/.bashrc.d/ -type l | sort); do
    source $file
  done
fi
```
## Other files ##

There are other files in this repository to configure some commands, like `gitconfig`, `inputrc`… all of them under `rc` directory.

This files should be linked at `/home/user` with their corresponding names, e.g.:

```bash
user@host:~:$ ln -s projects/linux-resources/rc/gitconfig .gitconfig
user@host:~:$ ln -s projects/linux-resources/rc/inputrc .inputrc
```
Also, there are more files to configure other appliactions like Sublime Text. This other files should be linked in their corresponding places.

## Configuration files overview ##

### BASH ###

Files in `bashrc.d` directory:

- `alias`: Custom aliases (ll, la, df...).
- `bash-config`: BASH shell configuration (history, history size...).
- `keybindings`: Some BASH keybindings.
- `prompt`: Custom prompt (including jobs, user, host, screen/tmux, git, return status...);
- `utils`: Utility functions (currently trim, trim-left and trim-right).

There are symlinks linking to these files to ensure precedence:

- `00 -> bash-config` and `05 -> keybindings` (0x for BASH configuration).
- `10 -> utils` (1x for BASH utilities).
- `20 -> alias` (2x for user configuration).
- `30 -> prompt` (3x for more user configuration).
- `90 -> local` (9x for some local configuration; not included into this repository).

### Tools ###

Files in `bin` directory are tools for common use. See the directory.

### RC files ###

Files in `rc` customize several commands:

- `gitconfig`: Configures Git.
- `inputrc`: Configures BASH completion.
- `screenrc`: Configures GNU/Screen.
- `vimrc`: Configures Vim editor.

### Sublime Text ###

Files in `sublime-text` directory are files to configure Sublime Text editor.

## Contribution ##

You can use and/or contribute to this configuration but keep in mind the KISS principle.

