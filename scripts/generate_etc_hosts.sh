#!/bin/bash
source /home/stack/stackrc
openstack server list  -c Networks  -c Name  -f value |  sed -e 's/ctlplane=//'g   | sed -e 's/\(.*\)\s\(.*\)/\2 \1/'
