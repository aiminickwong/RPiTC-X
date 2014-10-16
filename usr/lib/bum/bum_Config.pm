package bum_Config;

use strict;
require Exporter;

our @ISA = qw/Exporter/;

our @EXPORT = qw(
	PACKAGE
	VERSION
	
	PREFIX
	BINDIR
	LIBDIR
	DATADIR

	PKGLIBDIR
	PKGDATADIR
);

use constant {
	PACKAGE		=> 'bum',
	VERSION		=> '2.5.2',
	
	PREFIX		=> '/usr',
	BINDIR		=> '/usr/bin',
	LIBDIR		=> '/usr/lib',
	DATADIR		=> '/usr/share',

	PKGLIBDIR	=> '/usr/lib/bum',
	PKGDATADIR	=> '/usr/share/bum',
};

1;
