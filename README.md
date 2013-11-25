# Personal BASH Tools and Configuration Files #

## Introduction ##

This project includes all my personal files BASH tools and files to configure BASH environment.

The enviroment configuration is separated into several files: one for alias, one for BASH config, one for prompt an so on.

## Tools Installation ##

Make a link into your home directory to the binary tools directory. Example:

```bash
user@host:~:$ pwd
/home/user
user@host:~:$ ln -s ~/projects/personal-bash-tools/bin
```

Insert, if needed, your home bin path into PATH environment variable:

```bash
export PATH=$PATH:~/bin
```

## Environment Installation ##

Copy the files to any directory you want (I prefer put them into `~/.bashrc.d/`).

Then, add the following lines into `~/.bashrc`:

```bash
if [ -d ~/.bashrc.d ]; then
  for file in ~/.bashrc.d/*; do
    source $file
  done
fi
```
## Contribution ##

You can use and/or contribute to this configuration but keep in mind the KISS principle.

