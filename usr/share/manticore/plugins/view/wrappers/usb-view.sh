#!/bin/bash

PROTO_KEY="$1"
FORCE_KILL="$2"
KEY=$(mclient --quiet get $1)

VMWARE_LIB_PATH=/usr/lib/vmware
ARBITRATOR=vmware-usbarbitrator
DAEMON=vmware-view-usbd

#Make sure we are authorized.
#and we are not being told to force kill the utilities 
if [ "$KEY" = "view" -a ! "$FORCE_KILL" = "kill" ]; then
  #If so, launch daemons. 
  #(For view 1.6, they will detect if one is already running and
  #not launch another instance)
  view_funcs activate_view_usb
else
  #Kill daemons
  view_funcs kill_view_usb
fi

return 0
