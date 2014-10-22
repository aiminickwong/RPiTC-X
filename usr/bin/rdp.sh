#/bin/sh

dfreerdp  --disable-full-window-drag  --disable-menu-animations  --disable-theming --no-tls --no-nla -x b -g 1920x1080 -f --direct-surface $1 >/dev/null 2>/dev/null
