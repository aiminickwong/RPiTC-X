#! /bin/bash

echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

trap '' 2
if [ -f /tmp/usermode_rpitc ]
then
  /usr/bin/clear_console -q
  rm -fr /tmp/usermode*
  su - rpitc
fi

if [ -f /tmp/usermode_browser ]
then
  /usr/bin/clear_console -q
  rm -fr /tmp/usermode*
  su - browser
fi

if [ -f /tmp/usermode_root ]
then
  /usr/bin/killall -9 h264
  /usr/bin/clear_console -q
  rm -fr /tmp/usermode*
  while read -s -p "Press secret key to enter admin mode:" ans
  do
     case "$ans" in
      LOL)
        echo "password ok!"
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          exec startx >/dev/null 2>&1
        fi
        break;;
      *)
        echo "wrong password!"
        ;;
    esac
  done
fi
trap 2
