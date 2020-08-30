#
# Salomon-BSD - Simple log file monitor and analyzer (BSD port)
# Shebang adjustment script
# Copyright (C) 2020 by Ralf Kilian
# Distributed under the MIT License (https://opensource.org/licenses/MIT)
#
# GitHub: https://github.com/urbanware-org/salomon-bsd
# GitLab: https://gitlab.com/urbanware-org/salomon-bsd
#

script_dir=$(dirname $(readlink -f $0))
. ${script_dir}/core/shell.sh   # Use POSIX standard instead of 'source' here
shell_precheck

script_dir=$(dirname $(readlink -f $0))
temp_file_list="$(dirname $(mktemp -u))/salomon_file_list.tmp"
temp_file_shebang="$(dirname $(mktemp -u))/salomon_shebang.tmp"

grep "bash" <<< $BASH &>/dev/null
if [ $? -eq 0 ]; then
    shebang=$BASH
else
    shebang=$(whereis bash | awk '{ print $2 }')
fi

echo "Adjusting shebang to '#!$shebang'."
find $script_dir -type f | grep "\.sh$" > $temp_file_list
while read line; do
    sed -e "s#\#\!\/.*#\#\!$shebang#g" < $line > $temp_file_shebang
    cat $temp_file_shebang > $line
done < $temp_file_list

rm -f $temp_file_list
rm -f $temp_file_shebang

# EOF
