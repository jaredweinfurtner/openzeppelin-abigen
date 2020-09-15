#!/bin/bash

# https://unix.stackexchange.com/a/129401
while getopts ":o:p:" opt; do
  case $opt in
    o) out_dir="$OPTARG"
    ;;
    p) package="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# compile all contracts in the ./contracts directory into a combined abi+bin+other json
npx oz compile

# create the output directory in case it doesn't exist
mkdir -p $out_dir

# loop through the compiled contracts and generate go wrappers for them
# https://www.cyberciti.biz/faq/bash-loop-over-file/
for c in ./build/contracts/*
do
  # filename parsing: https://stackoverflow.com/a/965072/8203923
  file_with_extension=$(basename -- $c)
  extension="${file_with_extension##*.}"
  filename="${file_with_extension%.*}"

  # extract the abi and bin (bytecode) in separate files
  jq .abi $c > "/tmp/$filename.abi"
  jq .bytecode $c | sed 's/0x//; s/"//g;' > "/tmp/$filename.bin"

  # generate the go wrappers
  abigen --bin="/tmp/$filename.bin" --abi="/tmp/$filename.abi" --type $filename --pkg=$package --out="$out_dir/$filename.go"
done


