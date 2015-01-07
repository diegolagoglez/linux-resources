#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os.path

chars = {
	" ": "·",
	"\t": "→  ",
	"\n": "¶\n"
}

def print_file(file):
	if os.path.isfile(file):
		f = open(file, "r")
		while True:
			c = f.read(1)
			if not c:
				break
			if c in chars:
				sys.stdout.write(chars[c])
			else:
				sys.stdout.write(c)
	else:
		print >> sys.stderr, "ERROR: File does not exist: " + file

def main():
	for arg in sys.argv[1:]:
		print_file(arg)

main()
