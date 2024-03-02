#!/usr/bin/env bash

# specifyRM v1
function specifyRM
{
    echo "specifyRM function is just an example"
    
    specifyRM_match $@

    if [[ $? -eq 0 ]]
    then
        echo "Soon to be delete(rm -r) '$3'"
        echo "sleeping 10sec [ctrl+c to exit]"
        sleep 10
        # real RM here
        # rm -r "$3"
    fi
}
