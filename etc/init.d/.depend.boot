TARGETS = mountall.sh fake-hwclock mountkernfs.sh hostname.sh udev keyboard-setup console-setup mountall-bootclean.sh mountnfs-bootclean.sh urandom hwclock.sh networking alsa-utils mountdevsubfs.sh udev-finish kbd x11-common kmod procps
INTERACTIVE = udev keyboard-setup console-setup kbd
udev: mountkernfs.sh
keyboard-setup: mountkernfs.sh udev
console-setup: mountall.sh mountall-bootclean.sh mountnfs-bootclean.sh kbd
mountall-bootclean.sh: mountall.sh
mountnfs-bootclean.sh: mountall.sh mountall-bootclean.sh
urandom: mountall.sh mountall-bootclean.sh hwclock.sh
hwclock.sh: mountdevsubfs.sh
networking: mountkernfs.sh mountall.sh mountall-bootclean.sh urandom procps
alsa-utils: mountall.sh mountall-bootclean.sh mountnfs-bootclean.sh
mountdevsubfs.sh: mountkernfs.sh udev
udev-finish: udev mountall.sh mountall-bootclean.sh
kbd: mountall.sh mountall-bootclean.sh mountnfs-bootclean.sh
x11-common: mountall.sh mountall-bootclean.sh mountnfs-bootclean.sh
procps: mountkernfs.sh mountall.sh mountall-bootclean.sh udev
