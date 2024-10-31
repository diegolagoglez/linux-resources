#!/bin/bash

VERSION="0.1.0-20241031"

VERBOSE=

function error() {
    echo "ERROR: $1" >&2
    exit
}

function verbose() {
    if [ -n "$VERBOSE" ]; then
        echo "$1"
    fi
}

function show_help() {
    cat <<EOT
$(basename -- $0) v$VERSION -- Tool to run a script on lock/unlock screen."
Usage: $(basename -- $0) [Options]
Options:
  -l <CMD>   Run <CMD> when session is locked.
  -u <CMD>   Run <CMD> when session is unlocked.
  -v         Be verbose.
  -h         Show this help and exit.
EOT
}

function process_options() {
    while getopts ":hl:u:v" opt; do
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
            v)
                VERBOSE=yes
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
                verbose "LOCK detected. Run: $RUN_ON_LOCK"
                eval "$RUN_ON_LOCK"
            ;;
            *"{'LockedHint': <false>}"*)
                verbose "Unlock detected. Run: $RUN_ON_UNLOCK"
                eval "$RUN_ON_UNLOCK"
            ;;
        esac
    done < <(/usr/bin/gdbus monitor --system --dest org.freedesktop.login1)
}

function main() {
    process_options "$@"
    verbose "$(basename -- $0) START"
    check_options $#
    run_loop
}

main "$@"

