#!/bin/sh

# xxx todo: make these customisable via command line args
_prefix=IMG_
_suffix=.JPG
_suffix_lower=$(echo $_suffix | tr "[:upper:]" "[:lower:]")

if [ $# -ne 2 ]; then
    echo "error: usage: $0 <dir> <sequence>"
    echo "  e.g. \`$0 178 01\` will rename all ${_prefix}*${_suffix} files "
    echo "       in the '178/' directory to 178/01-nnnn${_suffix_lower} "
    echo "       (where <nnnn> represents the numeric part of the original"
    echo "        ${_prefix}*${_suffix} file name)"
    exit 1
fi

main() {
    local dir seq prefix suffix suffix_lower
    dir=$1
    seq=$2
    prefix=$_prefix
    suffix=$_suffix
    suffix_lower=$_suffix_lower

    for f in $(ls $dir/${_prefix}*${_suffix}); do
        echo f: $f
        echo $f | sed -e "s/$dir\/${_prefix}//" -e "s/${_suffix}$//" | awk "{
            print \"mv $dir/$_prefix\" \$1 \"$_suffix $dir/$seq-\" \
                  \$1 \"$_suffix_lower\"
        }" | sh
    done
}

main $1 $2

# vim:set ts=8 sw=4 sts=4 tw=78 et:
