#!/usr/bin/perl

use strict;
use warnings;

use constant CONFIG_FILE => '/etc/locale.nopurge';
use constant DPKG_CONFIG_FILE => '/etc/dpkg/dpkg.cfg.d/50localepurge';

my @PURGABLE_DIRS = (
    '/usr/share/locale/*',
    '/usr/share/gnome/help/*/*',
    '/usr/share/doc/kde/HTML/*/*',
    '/usr/share/omf/*/*-*.emf',
);
my @KEEP_DIRS = (
    '/usr/share/locale/locale.alias',
    '/usr/share/locale/@LOCALE@/*',
    '/usr/share/gnome/help/*/C/*',
    '/usr/share/gnome/help/*/@LOCALE@/*',
    '/usr/share/doc/kde/HTML/C/*',
    '/usr/share/doc/kde/HTML/@LOCALE@/*',
    '/usr/share/omf/*/*-@LOCALE@.emf',
    '/usr/share/omf/*/*-C.emf',
);

exit 0 unless -f CONFIG_FILE;

my %options = ();
my @dpkg_opts = ();
my $dpkgcnf = DPKG_CONFIG_FILE;

if (defined $ARGV[0] and $ARGV[0] eq '--remove') {
    if ( -f $dpkgcnf ) {
        print "Removing auto-generated file: $dpkgcnf\n";
        unlink $dpkgcnf or die "unlink $dpkgcnf: $!";
    }
    exit 0;
}

read_conf (CONFIG_FILE, \%options);

if ($options{'MANDELETE'}) {
    push @PURGABLE_DIRS, '/usr/share/man/*';
    push @KEEP_DIRS, '/usr/share/man/@LOCALE@/*';
    push @KEEP_DIRS, '/usr/share/man/man[0-9]/*';
}

if ($options{'USE_DPKG'}) {
    my @KEEPERS = @{ $options{'KEEP_LOCALES'} };
    open my $fd, '>', $dpkgcnf or die "open $dpkgcnf: $!";
    print $fd <<EOF ;
# DO NOT MODIFY/REMOVE THIS FILE - IT IS AUTO-GENERATED
#
# To remove/disable this, run dpkg-reconfigure localepurge
# and say no to/disable the "Use dpkg --path-exclude" option.
#
# To change what patterns are affected use:
# * dpkg-reconfigure localepurge
#   (to alter which locales are kept and whether manpages should
#    be purged)
# * Add a dpkg config file in /etc/dpkg/dpkg.cfg.d that is read
#   after this file with the necessary --path-include and
#   --path-exclude options.
#
# Report faulty patterns against the localepurge package.
#

EOF

    print $fd "# Paths to purge\n";
    foreach my $pd (@PURGABLE_DIRS) {
        emit_pattern ($fd, 'path-exclude', $pd, \@KEEPERS);
    }

    print $fd "# Paths to keep\n";
    foreach my $pd (@KEEP_DIRS) {
        emit_pattern ($fd, 'path-include', $pd, \@KEEPERS);
    }
    close $fd or die "close $dpkgcnf: $!";
} elsif ( -f $dpkgcnf ) {
    unlink $dpkgcnf or die "unlink $dpkgcnf: $!";
}

exit 0;

sub emit_pattern {
    my ($fd, $option, $pat, $keepers) = @_;
    if ($pat =~ m/\@LOCALE\@/) {
        foreach my $keep (@$keepers) {
            my $d = $pat;
            $d =~ s/\@LOCALE\@/$keep/;
            print $fd "$option=$d\n";
        }
    } else {
        print $fd "$option=$pat\n";
    }
}

sub read_conf {
    my ($filename, $opts) = @_;
    my @keep_locales = ();
    open my $fd, '<', $filename or die "open $filename: $!";
    $opts->{'KEEP_LOCALES'} = \@keep_locales;
    while ( my $line = <$fd> ) {
        chomp $line;
        next if $line =~ m/^\s*#/;
        next unless $line =~ m/^\S++$/o;
        if ($line =~ m/^[a-z]/) {
            push @keep_locales, $line;
        } else {
            $opts->{$line} = 1;
        }
    }
    close $fd;
}
