# debian-workshop-2024

It is for a workshop to show some commands to run as root and set up a debian server. It starts some number of Docker containers `limit` variable in the `env.conf` opens the necessary ports.

## init

In the router the ports between 6000 and 6010 needs to be open. Also the router should allow openning ports over upnpc. After that running `init.sh` will open other ports and start the docker containers.
