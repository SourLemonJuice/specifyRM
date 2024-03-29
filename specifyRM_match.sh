#!/usr/bin/env bash

# specifyRM_match v1
# 
# $1 == Match mode
# $2 == Mode options
# $3 == Path to be delete
# 
# return code:
# 0: matched
# 1: no match
# 16: input error
# 
# mode list:
# path.basename -- Match full path basename with $2
# path.prefix -- Match full path prefix with $2
# path.suffix -- Match full path suffix with $2
# dir.prefix -- just match directory name prefix with $2
# dir.suffix -- just match directory name suffix with $2
function specifyRM_match
{
    [[ -z "$2" ]] && echo "specifyRM_match: ERROR mode options is NULL -> '$2'" && return 16
    [[ -z "$3" ]] && echo "specifyRM_match: ERROR path parametric is NULL -> '$3'" && return 16
    [[ -n "$4" ]] && echo "specifyRM_match: ERROR redundant parameter \$4 is '$4'" && return 16

    while true
    do
        # realization options
        case "$1" in
        path.basename)
            # $(basename) will return file name so just match it
            local basename="$(basename "$3")"

            return $(test \
            "$basename" = "$2")
            ;;
        path.prefix)
            # bash has this syntax to intercept part of a string:
            # ${string_Variable:start_char_position:length}
            # by default "start_char_position" counting from the left side
            # 0 is the first character number of the string
            return $(test \
            "${3:0:${#2}}" = "$2")
            ;;
        path.suffix)
            # add a '-' "start_char_position" also can counting by right side
            # but there must be a space between ':' and '-'
            return $(test \
            "${3: -${#2}}" = "$2")
            ;;
        dir.prefix)
            # now strings aren't variable...
            local dirName="$(dirname "$3")"

            # preventing invalid character number from being used in string interception
            # '-le' <--> '<='
            if [[ ${#2} -le ${#dirName} ]]
            then
                # note: expr substr's start character number is 1
                return $(test \
                "$(expr substr "$dirName" 1 ${#2})" = "$2")
            else
                return 1
            fi
            ;;
        dir.suffix)
            local dirName="$(dirname "$3")"

            if [[ ${#2} -le ${#dirName} ]]
            then
                return $(test \
                "${dirName: -${#2}}" = "$2")
            else
                return 1
            fi
            ;;
        *)
            echo "specifyRM_match: Meow? Wrong mode name '$1'"
            return 16
            ;;
        esac
    done
}
