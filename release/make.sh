#!/usr/bin/env bash

#
# Salomon-BSD - Simple log file monitor and analyzer
# Release builder script
# Copyright (C) 2021 by Ralf Kilian
# Distributed under the MIT License (https://opensource.org/licenses/MIT)
#
# GitHub: https://github.com/urbanware-org/salomon
# GitLab: https://gitlab.com/urbanware-org/salomon
#

source ../core/global.sh
set_global_variables

script_dir=$(dirname $(readlink -f $0))
salomon_dir=$(sed -e "s/\/release$//g" <<< $script_dir)
salomon_version="salomon-bsd-release-$version"
salomon_archive="$salomon_version.tar.gz"
salomon_checksum="$salomon_archive.sha256"
git_clone=".git release snippets wiki"
temp_dir="$(dirname $(mktemp -u))/salomon-bsd"

echo -e "${cl_lc}Salomon-BSD $version release builder${cl_n}"

echo -e "  - Preparing release data..."
rm -f $salomon_version.tar.gz
rm -fR $temp_dir
mkdir -p $temp_dir
rsync -a $salomon_dir $temp_dir

echo -e "  - Removing non-relevant directories..."
for dir in $git_clone; do
    rm -fR $temp_dir/salomon-bsd/$dir &>/dev/null
done

echo -e "  - Removing non-relevant files..."
for markdown in $(find $temp_dir | grep "\.md$"); do
    rm -f $markdown
done

echo -e "  - Creating release archive ('${cl_yl}$salomon_archive${cl_n}')..."
mv $temp_dir/salomon-bsd $temp_dir/$salomon_version
tar czf $salomon_archive -C $temp_dir .

echo -e "  - Generating archive checksum" \
        "('${cl_yl}$salomon_checksum${cl_n}')..."
shasum -a 256 $salomon_archive > $salomon_archive.sha256

echo -e "${cl_lg}Finished.${cl_n}"
rm -fR $temp_dir

# EOF
