#!/usr/bin/bash

. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

PATH=/usr/bin:/usr/sbin:${PATH}

## Local variables
cfg='/opt/custom/share'

## Functions
function deploy() {
    folder="${cfg}/${1}"

    if [[ -d "${folder}" ]]; then
        # Deploy cronjobs
        [[ -d "${folder}/crontab" ]] && cat "${folder}/crontab/"* | crontab
    fi
}

deploy "global"

exit $SMF_EXIT_OK

