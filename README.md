# Personal BASH Configuration Files #

## Introduction ##

This project includes all my personal files to configure BASH environment.

This enviroment configuration is separated into several files: one for alias, one for BASH config, one for prompt an so on.

## Install ##

Copy the files to any directory you want (I prefer put them into `~/.bashrc.d/`).

Then, add the following lines into `~/.bashrc`:

```bash
for file in ~/.bashrc.d/*; do
  source $file
done
```
## Contribution ##

You can use and/or contribute to this configuration but keep in mind the KISS principle.

