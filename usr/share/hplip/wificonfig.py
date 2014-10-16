#! /usr/bin/python
# -*- coding: utf-8 -*-
#
# (c) Copyright 2003-2009 Hewlett-Packard Development Company, L.P.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
#
# Author: Don Welch
#

__version__ = '1.1'
__title__ = 'Wifi Configuration Utility'
__mod__ = 'hp-wificonfig'
__doc__ = "Wifi/Wireless/802.11 configuration utility for HPLIP supported printers. (Note: Only select wireless capable printers are supported by this utility)."

#Std Lib
import sys
import re
import getopt
import time
import operator
import os

# Local
from base.g import *
from base import device, utils, maint, tui, module
from prnt import cups


try:
    mod = module.Module(__mod__, __title__, __version__, __doc__, None,
                       (GUI_MODE,), (UI_TOOLKIT_QT4,))

    mod.setUsage(module.USAGE_FLAG_DEVICE_ARGS,
                 see_also_list=['hp-setup'])

    opts, device_uri, printer_name, mode, ui_toolkit, lang = \
        mod.parseStdOpts()

    device_uri = mod.getDeviceUri(device_uri, printer_name,
                                  filter={'wifi-config': (operator.gt, 0)},
                                  restrict_to_installed_devices=False)

    if not utils.canEnterGUIMode4():
        log.error("%s -u/--gui requires Qt4 GUI support. Exiting." % __mod__)
        sys.exit(1)

    try:
        from PyQt4.QtGui import QApplication
        from ui4.wifisetupdialog import WifiSetupDialog
    except ImportError:
        log.error("Unable to load Qt4 support. Is it installed?")
        sys.exit(1)

    app = QApplication(sys.argv)

    dlg = WifiSetupDialog(None, device_uri, standalone=True)
    dlg.show()
    try:
        log.debug("Starting GUI loop...")
        app.exec_()
    except KeyboardInterrupt:
        sys.exit(0)

except KeyboardInterrupt:
    log.error("User exit")

log.info("")
log.info("Done.")

