# debian-workshop-2024

It is for a workshop to show some commands to run as root and set up a debian server. It starts some number of Docker containers `limit` variable in the `env.conf` opens the necessary ports.

## init

In the firwall the ports between 6000 and 60 + `limit` needs to be open. Also it opens ports using upnpc. After that running `init.sh` will open other ports and start the docker containers.
