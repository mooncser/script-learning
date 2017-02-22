#!/bin/bash 


PROGNAME=${0##*/} 
PROGVERSION=0.1.0 

CONSUL_CLI_PATH=$(which consul-cli)
if [ "x${CONSUL_CLI_PATH}" == "x" ]; then
  echo "Couldn't find consul-cli executable, please refer to https://github.com/CiscoCloud/consul-cli/releases." 1>&2
  exit 2
fi

usage() 
{ 
  cat << EO
Usage: $PROGNAME [--version] [--help] <command> [<args>] 
            -h|--help & show this output
            -v|--version & show version information

Available commands are: 
EO
  cat <<EO | column -s\& -t 

            dump & Dump consul key/value from a path 
            load & Load consul key/value from a file
EO
} 

dump_usage()
{
  cat << EO
Usage: $PROGNAME dump [options] 

  Dump consul key/value from a specified path and write to file

Options:
EO
  cat <<EO | column -s\& -t

            --cms_url & Specify which path to dump
            --file & Target file that store key/value
EO
}

load_usage()
{
  cat << EO
Usage: $PROGNAME dump [options]

  Load consul key/value from a file to specified consul path

Options:
EO
  cat <<EO | column -s\& -t

            --cms_url=consul://<ip>:<port>/path & Path to consul key/value configuration
            --file & Source file that store key/value 
EO
}

if [ $# -eq 0 ]; then
  usage
fi

SHORTOPTS="hv" 
LONGOPTS="help,version,dump,load" 

ARGS=$(getopt -s bash --options $SHORTOPTS --longoptions $LONGOPTS --name $PROGNAME -- "$@" ) 

eval set -- "$ARGS" 

while true; do 
  case $1 in 
    -h|--help) 
      usage 
      exit 0 
      ;; 
    -v|--version) 
      echo "$PROGVERSION" 
      ;; 
    --) 
      shift 
      break 
      ;; 
    *) 
      shift 
      break 
      ;; 
  esac 
  shift 
done
