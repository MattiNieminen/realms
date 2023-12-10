#!/usr/bin/env bash

set -e

die() {
  echo -ne "$1" >&2
  exit 1
}

help() {
  echo -ne "Usage: $script_name task environment_name
Installs or runs isolated shell environments based on defined configuration.

Each environment must be installed with 'install' task.
After installing, run the environment with 'run' task.

See README.md for additional information.

The following environments are currently supported:
"

  for d in "$environments_dir"/* ; do
    echo "  * $(basename ${d//.sh})"
  done
}

get_dir() {
  echo "$(dirname $(readlink -f $0))"
}

init_constants() {
  app_name="${0##*/}"
  app_dir="$(get_dir $0)"
  environments_dir="$app_dir/environments"
  dots_dir="$app_dir/dots"
}

parse_args() {
  for arg in "$@"; do
    case "$arg" in
    -h|--help)
      help
      exit 0
      ;;
    -*)
      die "ERROR: Unknown option: $arg."
      ;;
    *)
      if [ -z "$task" ]; then
        task="$arg"
      elif [ -z "$environment_name" ]; then
        environment_name="$arg"
      else
        die "ERROR: too many arguments."
      fi
      ;;
    esac
  done

  if [ -z ${task+x} ]; then
    die "ERROR: task is missing."
  fi

  if  [ ! "$task" = "install" ] && [ ! "$task" = "run" ]; then
    die "ERROR: Unknown task: $task"
  fi

  if [ -z ${environment_name+x} ]; then
    die "ERROR: environment name is missing"
  fi

  environment_script="$environments_dir/$environment_name.sh"

  if [ ! -f "$environment_script" ]; then
    die "ERROR: Unknown environment name: $environment_name"
  fi
}

load_environment() {
  home="$HOME/$app_name/$environment_name"
  . "$environment_script"
  dots="$(echo "$dots" |  xargs)"
  packages="$(echo "$packages" |  xargs)"
}

install_environment() {
  mkdir -p "$home"

  for d in $dots; do
    echo "Installing dots: $d"
    d_dir="$dots_dir/$d"

    if [ -d "$d_dir" ]; then
        cd "$d_dir"
        ls -la
        HOME="$home" . install.sh
        echo
    else
        die "ERROR: Dots not found: $p"
    fi
  done
}

run_environment() {
  if [ ! -d "$home" ]; then
    die "ERROR: Environment has not been installed."
  fi

  HOME="$home" nix-shell --packages $packages --command "name=$environment_name $shell"
}

execute_task() {
  if [ "$task" = "install" ]; then
    install_environment
  elif [ "$task" = "run" ]; then
    run_environment
  fi
}

init_constants
parse_args "$@"
load_environment
execute_task
