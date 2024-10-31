#!/bin/bash

function error() {
	echo "ERROR: $1" >&2
	exit
}

function show_help() {
	cat <<EOT
$(basename -- $0) v$VERSION -- Tool to run a script on lock/unlock screen."
Usage: $(basename -- $0) [Options]
Options:
  -l <CMD>   Run <CMD> when session is locked.
  -u <CMD>   Run <CMD> when session is unlocked.
  -h         Show this help and exit.
EOT
}

function process_options() {
	while getopts ":hl:u:" opt; do
		case "$opt" in
			h)
				show_help
				exit 1
			;;
			l)
				RUN_ON_LOCK="$OPTARG"
			;;
			u)
				RUN_ON_UNLOCK="$OPTARG"
			;;
			\?)
				error "Invalid option: -$OPTARG"
			;;
			:)
				error "Option -$OPTARG requires an argument."
			;;
		esac
	done
}

function check_options() {
	if [ $1 == 0 ]; then
		error "Invalid command line arguments. Use -h to see help."
	fi
	if [ -z "$RUN_ON_LOCK" -a -z "$RUN_ON_UNLOCK" ]; then
		error "Either -l or -u options must be used."
	fi
}

function run_loop() {
	while read line; do
		case "$line" in
			*"{'LockedHint': <true>}"*)
				eval "$RUN_ON_LOCK"
			;;
			*"{'LockedHint': <false>}"*)
				eval "$RUN_ON_UNLOCK"
			;;
		esac
	done < <(gdbus monitor --system --dest org.freedesktop.login1)
}

function main() {
	process_options "$@"
	check_options $#
	run_loop
}

main "$@"

