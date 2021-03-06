SmartOS as NAS
==============

Configuration scripts for SmartOS.

Basic setup

1. Setup public key authentication creating the authorized_keys file in the /usbkey/config.inc directory and adding the root_authorized_keys_file parameter at the end of the /usbkey/config file:

    mkdir /usbkey/config.inc
    cat id_rsa.pub > /usbkey/config.inc/authorized_keys
    echo "root_authorized_keys_file=authorized_keys" >> /usbkey/config

After verifying that passwordless login works, modify /usbkey/ssh/sshd_config file changing PasswordAuthentication to "no".

2. Modify the hostname with:

    echo "hostname=stormstone" >> /usbkey/config

Services

The structure of the /opt/custom folder:

    share
        global
            crontab  - crontab entries
            root     - files in root directory (e.g. .mailrc)
            script   - various scripts
            system
                cron - the scripts run by crontab
                etc  - persistence for specified files from /etc
        svc          - scripts run by SMF manifest files (.sh)
        vm           - simple definition files for KVM and zone VMs
    smf              - SMF manifest files (.xml)

1. Postboot configuration (stormstone.[xml|sh]) - the script restores the files in the root folder and runs all the scripts it can find in "script" and "crontab" directories under share/global.

2. Persist configuration files (persist-syscfg.[xml|sh]) - keeps /etc/passwd and /etc/group files up-to-date. To add a new user and group, you need to run svcadm disable svc:/site/persist-syscfg, make your changes in group and passwd files, then run svcadm enable svc:/site/persist-syscfg.

3. Load UPS driver (ups-driver.[xml|sh]) - loads the UPS driver for Mustek PowerMust 636.

4. Start NUT services (ups-nut.[xml|sh]) - enable NUT services.

Crontab

Because my UPS doesn't work seemlessly with SmartOS, I had to find I way to keep NUT running. For this, I have a cronjob checking every two minutes if the services are alive and if not, it restarts them. An ugly solution, but for now it seems to do what it is meant to do.
