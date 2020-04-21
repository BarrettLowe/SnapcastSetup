# Snapcast Setup for Synchronized Multiroom Audio

This repo is an overview of a working solution for snapcast multiroom audio. You will find a working dockerfile that installs the master branch version of snapcast as well as a config file. The config file outlines the streams I use currently in my home. It creates two Spotify Connect devices using [librespot](https://github.com/librespot-org/librespot) which is built in the docker image (using a cargo crate). There are two pipes that are able to receive music as well though, for my purposes, one of the pipes is named 'Nothing' because I wanted an empty source for my setup.

The client setup is outlined as well, though, may vary depending on the hardware used. I'm running clients on different platforms and they all follow (generally) the same process.

## Server Setup

I'm currently running on an x86 box with Ubuntu 19.10. Docker is running in the container posted in this repository and it started using docker-compose (file also included). Note that the container is on the 'host' network. This isn't my preference but librespot does some mdns stuff that doesn't work quite right otherwise. There may be a way around it. I haven't read up.

## Client Setup (Raspberry Pi)
The following is working for me on the Pi B3+ and Pi Zero W (via HDMI).

Setup from fresh image with wifi/ssh if desired

Run the following code with replacements:
- Make sure to get the latest .deb from the github releases
- When editing /etc/default/snapclient, put in an appropriate ID and Host for the device


        `SNAPCLIENT_OPTS="-h <host_ip> -i <device_id>"`
- NOTE: The master branch may have more recent fixes. Follow guidelies on from the [snapcast](https://github.com/badaix/snapcast) repository to build from source.
```
sudo apt-get update && sudo apt-get upgrade -y
mkdir snapcast
cd snapcast
wget https://github.com/badaix/snapcast/releases/download/v0.19.0/snapclient_0.19.0-1_armhf.deb
sudo dpkg -i snapclient_0.19.0-1_armhf.deb
sudo apt-get -f install
* Edit the options in /etc/defaults/snapclient *
sudo systemctl enable snapclient
sudo service snapclient start
```

Optionally you can run `sudo raspi-config` and force the Pi to use the 3.5mm jack or HDMI for audio output.

### Other devices
I aquired one of [these](https://libre.computer/products/boards/aml-s805x-ac/) La Frite boards when they ran their kick starter campaign. I installed the provided debian distrobution and was able to get snapcast running there as well though it's not as consistent and there are some errors that cause me to have to restart occasionally. I'm working through them but for now, it's an acceptable client connected to our family room tv!