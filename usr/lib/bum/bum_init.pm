
############################################################################
#    Copyright (C) 2005 by Fabio Marzocca                             #
#    thesaltydog@gmail.com                                                 #
#                            
#                                                  #
#    This program is free software; you can redistribute it and or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation; either version 2 of the License, or     #
#    (at your option) any later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
#
# 
# 
############################################################################


package bum_init;
use strict;


# $hdata holds this table of data: - script / text / daemon - for each script in summary view
my $hdata;


sub init_human_text{
	for(
	['acpid',_('Perform intelligent power management of your system'),'acpid'],
	['acpi-support',_('For laptops, does  power management and enables hotkeys'),0],
	['alsa',_('Sound Architecture Services '),0],
	['anacron',_('Runs system housekeeping chores on specified days'),0],
	['apache',_('Web Server'),'apache'],
	['apache2',_('New generation Web Server'),'apache2'],
	['apmd',_('Monitors battery status for some older laptops'),'apmd'],
	['apport',_('Tool to report program crashes'),0],
	['atd',_('Enables scheduling of jobs'),'atd'],
	['autofs',_('Automounter for Linux'),'autofs'],
	['avahi-daemon', _('Discover services and hosts on a local network'),'avahi-daemon'],
	['binfmt-support',_('Support for extra formats to run programs'),0],
	['bind9', _('Service to get internet domain names'),'named'],
	['bittorrent',_('Easy scatter-gather network file transfer'),'bttrack.bittorr'],
	['bootclean', _('Scripts for initializing and shutting down the system'),0],
	['bootlogd',_('Saves messages at boot to a log file'),'bootlogd'],
	['bluetooth',,_('Bluetooth services'),'hcid'],
	['bluez-utils',_('Bluetooth services'),'hcid'],
	['clamav-freshclam',_('Update virus database'),'freshclam'],
	['cron',_('Runs system housekeeping chores on specified dates/times'),'cron'],
	['cups',_('Manages print jobs'),'cupsd'],
	['cupsys',_('Manages print jobs'),'cupsd'],
	['dbus-1',_('Delivers messages between applications'),'dbus-daemon-1'],
	['dbus',_('Delivers messages between applications'),'dbus-daemon'],
	['ddclient',_('Updates your details on DNS hosting providers'),'ddclient'],
	['dns-clean',_('Configures your system for internet access via a modem'),0], 
	['dhcp3-server',_('Provides IP addresses to clients via DHCP'),'dhcpd3'],
	['dictd',_('Dictionary Server'),'dictd'],
	['evms',_('Hard Disk Volume Management'),0],
	['fam',_('Detects changes in files/directories'),'famd'],
	['fetchmail',_('Mail retrieval and forwarding utility'),'fetchmail'],
	['festival',_('A Text to Speech synthesis software'),'festival'],
	['fnfxd',_('Power and special key management for Toshiba laptops'),'fnfxd'],
	['gdm',_('GNOME Display Manager'),'gdm'],
	['hal',_('A layer for hardware support and detection'),'hald'],
	['hdparm',_('Tunes hard disk parameters for high performance'),0],
	['hotkey-setup',_('Auto-configures laptop hotkeys'),0],
	['hotplug',_('Detects new devices when plugged in'),0],
	['hplip',_('HP Printing and Imaging System'),'hpiod'],
	['hpoj',_('HP OfficeJet Linux driver'),'ptal-printd'],
	['hsf',_('Conexant HSF modem management'),'hsfdcpd'],
	['ifupdown-clean',_('Tools to configure network services'),0],
	['inetd',_('Manager for incoming Internet connections'),'inetd'],
	['kdm',_('KDE Display Manager'),'kdm'],
	['klogd',_('Logs important system events'),'klogd'],
	['landscape-client',_('Web-base tool for managing Ubuntu systems'),'landscape-client'],
	['laptop-mode',_('Auto-enables laptop mode when running on batteries'),0],
	['lvm',_('Handles physical Hard Disk Volumes in Logical groups'),0],
	['makedev',_('Creates special files to interact with hardware'),0],
	['mdadm',_('Manages multiple disk devices for fault-tolerance'),'mdadm'],
	['mdadm-raid',_('Manages multiple disk devices for fault-tolerance'),'mdadm'],
	['mpd',_('Allows remote access for playing music'),'mpd'],
	['mysql',_('Fast and stable SQL database server'),'mysqld'],
	['networking',_('Manages your Internet connection'),0],
	['ntp',_('Update the system time using the Internet'),'ntpd'],
	['ntpdate',_('Update the system time using the Internet'),0],
	['nvidia-glx',_('NVIDIA video card management'),0],
	['nvidia-kernel',_('Common files for NVIDIA video cards'),0],
	['pcmcia',_('Manages the insertion/removal of Laptop cards'),'cardmgr'], 
	['postfix',_('High performance Mail Server'),'master'],
	['powernowd',_('Controls CPU speed and voltage to save power'),'powernowd'],
	['ppp',_('Manages internet access via a modem'),'pppd'],
	['pppd-dns',_('Restores DNS'),'pppd'],
	['policykit',_('Framework for managing administrative privileges'),0],
	['pulseaudio',_('New generation audio server'),'pulseaudio'],
	['readahead',_('Speeds up boot by starting operations early'),0],
	['rsync',_('Fast remote file copy program'),'rsyncd'],
	['saned',_('Scanner services'),'saned'],
	['samba',_('Share files among computers on a LAN'),'smbd'],
	['sl-modem-daemon',_('SmartLink modem management'),'slmodemd'],
	['smartmontools',_('Monitors hard drives with SMART'), 'smartd'],
	['squid',_('Internet WWW proxy server'),'squid'],
	['spamassassin',_('Mail spam filter'),'spamd'],
	['ssh',_('Allows users securely to log into the machine remotely'),'sshd'],
	['stop-bootlogd',_('Stops saving boot messages to a log file'),0],
	['sudo',_('Allows specific users to gain superuser status'),0],
	['sysklogd',_('System Logging Service'),'syslogd'],
	['tpb',_('Program to use the IBM ThinkPad(tm) special keys'),'tpb'],
	['udev',_('Creates new devices when plugged in'),'udevd'],
	['udev-mtab',_('Creates new devices when plugged in'),'udevd'],
	['usplash',_('User bootsplash utility'),0],
	['vbesave',_('Save/Recover video state'),0],
	['vboxdrv',_('VirtualBox linux kernel module'),'vboxdrv'],
	['vmware-server',_('Virtual Machine Server'),'vmware-serverd'],
	['vsftpd',_('The Very Secure FTP daemon'),'vsftpd'],
	['webmin',_('Web-based remote administration for this computer'),'miniserv.pl'],
	['Win4LinPro',_('Virtual Bridges virtualization services'),'win4prod'],
	['wifi-radar',_('Graphical utility for managing wi-fi connections'),'wifi-radar'],
	['xorg-common',_('Main Graphical Interface'),'Xorg'],
	['zope',_('Open Source Web Application Server'),'zope']
	){
	    my($name,$description,$daemon)=@$_;
	    $hdata->{$name}->{description} = $description;
    	    $hdata->{$name}->{daemon} = $daemon;
	    }       
}

sub get_human_text{
	return $hdata;
	}

1;
