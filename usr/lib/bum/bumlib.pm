
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
############################################################################


package bumlib;
use strict;



use constant TRUE  => 1;
use constant FALSE => 0;


my $ETC_DIR = "/etc";
my $etc_rc =  "/etc/rc";
my $initd =  "/etc/init.d";
my  @cfg_levels = qw/2 3 4 5/; 			# default runlevels to affect if not specified
my @rls = qw/ 1 2 3 4 5 7 8 9 0 6/;
my @cfg_stoplevels = qw/0 1 6/;
my $runlevel_cmd = '/sbin/runlevel';

my $DATA_DIR = "/var/lib/bum/";
my $DATA_FILE = $DATA_DIR."numbers";
my $PKGS_FILE = $DATA_DIR."packages";

my @unselects = ("\^\\\.\$", "\^\\\.\\\.\$", "\^rc\$", "\^rcS\$", "\^README\$",
                  "\^skeleton\$", ".*\\\.dpkg-dist\$", ".*\\\.dpkg-old\$",
                  ".*\\\.sh\$");
my $DEBUG_STRING = ">/dev/null 2>&1";

### Globals to module
my ($g_rcdf, $g_data, $g_default, $g_initd,$g_pkgname,$g_rcS,$g_rcSoff);


my $DEBUG = 0;


####################################################################
# Send the full list to GUI

sub get_full_list
{
 my @list;
 my $element;

 get_packages();

# Get list & service number in runlevels
# services on
foreach my $i (@$g_default) {
	my $arr =$g_rcdf->{$i};
	
	if($arr->[7] ne '-01'){next;}; #skip if S  in rcS 
        $element ="1,".$i.",";
        for (my $y=0; $y<7; $y++) {
		if ($arr->[$y] eq '-01' && $arr->[$y+10] eq '-01') 
					{$element.="---,"; next;}
		if ($arr->[$y] ne '-01') {$element.="S".$arr->[$y].",";}
	        if ($arr->[$y+10] ne '-01') {$element.="K".$arr->[$y+10].",";}
            }
        push (@list,$element);
	}



# services off
foreach my $i (@$g_initd) {
	my $arr =$g_rcdf->{$i};
	if (defined $arr->[17] && $arr->[17] ne '-01') {next;}	#skip if defined rcS.d K
        $element= '0,'.$i.",";
        for (my $y=0; $y<7; $y++) {
			if (!defined $arr->[$y] && !defined $arr->[$y+10]) {
				$element.="---,"; 
				next;
				}
			if ($arr->[$y] eq '-01' && $arr->[$y+10] eq '-01') {
				$element.="---,";
				next
				}
			if (defined $arr->[$y] && $arr->[$y] ne '-01') {
				$element.="S".$arr->[$y].",";
				}
	        if (defined $arr->[$y+10] && $arr->[$y+10] ne '-01') {
				$element.="K".$arr->[$y+10].",";
				}
            }
        push (@list,$element);
  }
					
  return \@list;
}

###################################################
# Sed rcS.d list to GUI
#
sub get_full_rcS_list
{
 	my @list;
	my $element;
	


# services on
	foreach my $i (@$g_rcS) {
		my $arr =$g_rcdf->{$i};
        	$element ="1,".$i.",";
			#runlevel 0 Halt K
			if ($arr->[10] eq '-01') {
				$element .= "---,";
				}
			else {
				$element .="K".$arr->[10].",";
				}
			#runlevel rcS.d
			if ($arr->[7] eq '-01' && $arr->[17] eq '-01') {
				$element.="---,";
				}
			if ($arr->[7] ne '-01') {
				$element.="S".$arr->[7].",";
				}
	        if ($arr->[17] ne '-01') {
					$element.="K".$arr->[17].",";
					}
	            	#runlevel 6 Reboot
			if ($arr->[16] eq '-01') {
				$element .= "---,";
				}
			else {
				$element .="K".$arr->[16].",";
				}
			
        	push (@list,$element);
		}

# services off
	foreach my $i (@$g_rcSoff) {
		my $arr =$g_rcdf->{$i};
        	$element ="0,".$i.",";
			#runlevel 0 Halt K
			if ($arr->[10] eq '-01') {
				$element .= "---,";
				}
			else {
				$element .="K".$arr->[10].",";
				}
			#runlevel rcS.d off
			if ($arr->[17] eq '-01') {
				$element.="---,";
				}
	        	if ($arr->[17] ne '-01') {
					$element.="K".$arr->[17].",";
					}
	            	#runlevel 6 Reboot
			if ($arr->[16] eq '-01') {
				$element .= "---,";
				}
			else {
				$element .="K".$arr->[16].",";
				}
			
        	push (@list,$element);
		}

	return \@list;
}

##################################################################
# Apply changes
#
# %hashon %hashoff  es: {alsa 
#					     gdm 
#						.....}
# input list must at least have in field [0] the activation toggle
# and in field [1] the package name.
##########################################################
sub make_changes
{
 my ($list,$ret) = @_; 			
 my $key;
 my @res_on = ();
 my @res_off = ();
 my $hashon= {};
 my $hashoff = {};
 my $run =0;

	return if ($ret eq 'cancel') ;

	$run= 1 if ($ret eq 'yes');


#create and populate hashes from list from $list
 foreach $key ( @{$list} ) {
	if ($key->[0]) {$hashon->{$key->[1]}="OK";}  #$key->[1] is the package name
        else {$hashoff->{$key->[1]}="OK";}
		}


#create and populate res_on 
 foreach $key (keys(%{$hashon})) {
	if (!is_already_on($g_default,$key))
			{push(@res_on, $key);}
	}

#create and populate res_off
 foreach $key (keys(%{$hashoff})) {
	if (!is_already_off($g_initd, $key)  )
			{push(@res_off, $key);}
	}


  &exec_update($run,on=>\@res_on, off=>\@res_off, data=>$g_data);
 
}

###############
sub is_already_on
{
   my ($ref,$pkg) = @_;
  if ($ref==FALSE) {$ref=$g_default;}

  my $key;

	foreach $key (@{$ref}) {
		if ($key eq $pkg) {return TRUE;}
		}
	return FALSE;
   
}

#######################
sub is_already_off
{
  my ($ref,$pkg) = @_;
 if ($ref==FALSE) {$ref=$g_initd;}

 my $key;

	foreach $key (@{$ref}) {
		if ($key eq $pkg) {return TRUE;}
		}
	return FALSE;
   
}

##########################################################
# Return apt-cache info if available
sub get_cache_info
{
	my $key = shift;
	my $ret = TRUE;
	my $s_info = "";
	my $pkg = $key;
	my $descr = "";

	if ( exists($g_pkgname->{$key}) ) {
		$pkg = $g_pkgname->{$key};
	       
	}

	if ($pkg ne "") {
       		$s_info = `apt-cache show $pkg`; #dpkg --print-avail
       		my $start = rindex($s_info,"Description");
       		my $end = rindex($s_info,"Bugs");
		if ($start >= $end) {$end = $start-1;}
		$s_info=substr($s_info,$start,$end-$start);
       		$start = index($s_info,":");
       		if ($start > -1 ) {
       			$s_info = substr $s_info,$start+1;
       			}
       
		$end = index($s_info,"\n");
		$descr = substr($s_info,0,$end);
		$s_info = substr($s_info, $end+1);
        }

	if ($s_info eq "" ) { 
		$s_info=_("Sorry, no information found for this package.");
		$pkg=$key;
		$ret=FALSE;
		}

	return ($descr,$s_info,$ret);

}

##################################################################
# Return info (if available) on script

sub new_get_script_info
{
	my $key = shift;
	my $ret = TRUE;
	my $s_info = "";
	my $pkg = "";
	my $descr = "";

	($descr,$s_info,$ret) = get_cache_info($key);

	my($summ,$sum_ret) = get_summ_info($key);
	if ($sum_ret) {
		$pkg=$key;
		$descr=$summ;
		}

	return ($descr,$s_info,$ret);


}

################################################
# Get summary info text
#
sub get_summ_info
{
	my $key = shift;
	my $ret = TRUE;
	my $s_info = "";
	my $pkg = "";
	my $descr = "";
	my $dummy = "";

	#first check in human text
	my $human = bum_init::get_human_text();
	if(exists $human->{$key} ){
        	return ($human->{$key}->{description}, TRUE);
	}

	#otherwise get cache information
	($descr,$dummy,$ret) = get_cache_info($key);

	return ($descr,$ret);

}

#########################################################
# Change service priority
#
sub service_priority
{
	my ($key,$start,$stop) =  @_; 
	
 		foreach my $rl(@cfg_levels) {
			update_link($key,$rl,'S',$start);
			}
		#update 'K' links
  		foreach my $rl(@cfg_stoplevels) {
			update_link($key,$rl,'K',$stop);
			}
	
	system("logger -t bum $key changed priority  S=$start K=$stop");
	
}

##########################################################
## Stop the service NOW
sub stop_service
{
my $key = shift;
return system("/etc/init.d/".$key." stop ".$DEBUG_STRING) ;
}

##########################################################
## Start the service NOW
sub start_service
{
	my $key = shift;
	my $ret = system("/etc/init.d/".$key." start".$DEBUG_STRING);
	return $ret;
}

############################################################
# get a single package name
#
sub old_get_pkg
{
	my $key = shift;

	my ($grep_src, $pkg);

	my $dpkg_dir = "/var/lib/dpkg/info/";
	$grep_src = $ETC_DIR."/init.d/".$key."\$ ".$dpkg_dir."*.list";
	$pkg = `grep $grep_src`;
	$pkg =~ s/$dpkg_dir//g;
	$pkg =~ s/(.list).*//g;
	chomp($pkg);
	
	my $fullpath =$ETC_DIR."/init.d/".$key;
	my $dret = `dpkg -S $fullpath 2>&1`;
	chomp($dret);
	my ($pkg2) =$dret=~ /(\w+.*?)\:/;
	print STDERR "$dret ===>  $pkg2\n";
 	
	return $pkg ;
}

sub get_pkg
{
	Gtk2->main_iteration while ( Gtk2->events_pending );
	my $key = shift;
	my $fullpath =$ETC_DIR."/init.d/".$key;
	my $dret = `dpkg -S $fullpath 2>&1`;
	my ($pkg) =$dret=~ /(\w+.*?)\:/;
	
	return "" if ($pkg eq "dpkg");
	return $pkg;

}

#################################################
# get all packages names

sub get_packages
{
	my ($key,$pkg);
	
	#Main initialization routines
	
	#check if /var/lib/bum exists
	if (!(-d $DATA_DIR)) { `mkdir -p $DATA_DIR`;}

 	$g_rcdf = &read_rcd_default(root_dir=>$ETC_DIR);
	$g_data = &read_data(file=>$DATA_FILE);
 	$g_default = &select_default(rcdf=>$g_rcdf, data=>$g_data);  	#scripts ON
 	$g_initd = &read_initd_dir(root_dir=>$ETC_DIR);
 	$g_initd = &select_unlinked_initd(initd=>$g_initd, rcdf=>$g_rcdf,		
                                unselects=>\@unselects);			#scripts off

 	&write_data(file=>$DATA_FILE, data=>$g_data);

	$g_rcS = &select_rcS(rcdf=>$g_rcdf, data=>$g_data);	#rcS on
	$g_rcSoff=&init_rcSoff(rcdf=>$g_rcdf);			#rcS off

	#######################
	
	if ( -e $PKGS_FILE  )        #packages file exists
	{
	open(IN, $PKGS_FILE)|| die "Cannot open file $PKGS_FILE !";
	while(<IN>){
    		next if ( /^\#/ );    
		if (/(\S+)\s+(\S+)/) {		
      			$g_pkgname->{$1} = $2;
			}   	
  		} ## while(<IN>)
	close(IN);
	foreach  $key (@$g_default) {	
		next if ( exists($g_pkgname->{$key}) );
		$g_pkgname->{$key}=get_pkg($key);
		}
	foreach  $key (@$g_initd) {
		next if ( exists($g_pkgname->{$key}) );
		$g_pkgname->{$key}=get_pkg($key);
		} 
	foreach  $key (@$g_rcS) {
		next if ( exists($g_pkgname->{$key}) );
		$g_pkgname->{$key}=get_pkg($key);
		} 
	foreach  $key (@$g_rcSoff) {
		next if ( exists($g_pkgname->{$key}) );
		$g_pkgname->{$key}=get_pkg($key);
		} 
	}
	else					#packages file doesn't exist
	{
	foreach my $key(keys %$g_rcdf) {
		$g_pkgname->{$key}=get_pkg($key);
		}
	}

	#write package file
	open(OUT, "> ".$PKGS_FILE) || die "Cannot write file $PKGS_FILE !";		
	foreach  $key (keys(%{$g_pkgname})){
	    	print OUT $key." ".$g_pkgname->{$key}."\n";
  	
		}
  	close(OUT);

}
#######################################################################
## MODULE: read_initd_dir
## DESC: Collect files in init.d/ directory.
sub read_initd_dir{
##
  my $dir = $ETC_DIR."/init.d";
  opendir(DIR, $dir) || die "No such directory: $!";
  my(@dirs) = readdir(DIR);
  close(DIR);
##

return \@dirs;
} ## read_initd_dir

#######################################################################
## MODULE: read_rcd_default
## DESC: Read files in rc?.d(?:=0..6) directory and generate %rcdf.
##         %rcdf->{'package'} -> [0]  service num in rc0.d/S??package [10]... K??

sub read_rcd_default {

  my(%ref) = @_;
##
  my $root_dir = $ref{'root_dir'};
  my %rcdf = ();
#  my($i);
  my $dir;
## rc?.d
  my($start, $end);
  for ( my $i = 0; $i <= 6; $i++ ) {
    $dir = $root_dir."/rc".$i.".d";
    ($start, $end) = &read_rc_dir(dir=>$dir);
    &setup_rcd(rcdf=>\%rcdf, rcfile=>$start, dirnum=>$i, margin=>0);
    &setup_rcd(rcdf=>\%rcdf, rcfile=>$end, dirnum=>$i, margin=>10);
  }
## rcS.d
  $dir = $root_dir."/rcS.d";
  ($start, $end) = &read_rc_dir(dir=>$dir);

  &setup_rcd(rcdf=>\%rcdf, rcfile=>$start, dirnum=>7, margin=>0);
  &setup_rcd(rcdf=>\%rcdf, rcfile=>$end, dirnum=>7, margin=>10);


return \%rcdf;
} ## read_rcd_default

#######################################################################
## MODULE: setup_rcd
sub setup_rcd{

  my(%ref) = @_;
##
  my $rcdf = $ref{'rcdf'};
  my $rcfile = $ref{'rcfile'};
  my $dirnum = $ref{'dirnum'};
  my $margin = $ref{'margin'};
##
  my $package; my $num;
  foreach my $file ( @{$rcfile} ) {
    $package = $file->{'name'};
    $num = $file->{'num'};
#print $package." ".$num." $margin $dirnum\n";
    if(! exists($rcdf->{$package})){
      $rcdf->{$package} = &new_rcd();
      #print "Generate ".$package."\n";
    }
    $rcdf->{$package}->[$dirnum+ $margin] = $num;
  } ## foreach


} ## setup_rcd()

#######################################################################
## MODULE: read_rc_dir
## DESC: Open directory specified in $dir, and list Start/Stop service

sub read_rc_dir{
  my($self) = shift if(defined($_[0]) && (ref($_[0]) ne ''));
  my(%ref) = @_;
##
  my $dir = $ref{'dir'};
##
  opendir(DIR, $dir) || die "No such directory: $!";
##
  my @starts = ();
  my @stops = ();
  my @dirs = readdir(DIR);
  foreach (reverse sort @dirs ) {
    if(/^S([0-9][0-9])(.*)$/){
      push(@starts, &new_file(num=>$1, name=>$2));
      next;
    } ## if
    if(/^K([0-9][0-9])(.*)$/){
	next if (already_in_start(\@starts,$2));   	#eliminate stop num if package already in start in this level (i.e.anacron)
      push(@stops, &new_file(num=>$1, name=>$2));
      next;
    } ## if
  } ## while()
  closedir(DIR);


  return(\@starts, \@stops);
} ## read_rc_dir

sub already_in_start {
	my ($arr,$name) =@_;
	
	foreach my $key (@{$arr}) {
		return 1 if ($key->{'name'} eq $name);

	}
	return 0;
}

#######################################################################
## MODULE: select_unlinked_initd
## DESC: Compare between %rcdf and @initd, and list file in init.d/

sub select_unlinked_initd{

   my(%ref) = @_;
##
  my $initd = $ref{'initd'};
  my $rcdf = $ref{'rcdf'};
  my $unselects = $ref{'unselects'};
##
  my @new_initrd = ();
  my $unselect;
##

  foreach my $key (@{$initd}){
    next if ( &check_unselect(file=>$key, unselects=>$unselects) );
    if ( (    ! exists($rcdf->{$key})  || 
         		( 
	  		 #( $rcdf->{$key}->[10] != -1 ) &&
          		# ( $rcdf->{$key}->[11] != -1 ) && 
           		( $rcdf->{$key}->[12] ne '-01' ) && 
           		( $rcdf->{$key}->[13] ne '-01' ) && 
           		( $rcdf->{$key}->[14] ne '-01') && 
           		( $rcdf->{$key}->[15] ne '-01' ) 
          		# ( $rcdf->{$key}->[16] != -1 ) 
				))){ 

     push(@new_initrd, $key);
    }
  }

  return \@new_initrd;
} ## select_unlinked_initd()

#######################################################################
## MODULE: check_unselect
## DESC: Check if 'file' exists in unselects array.
sub check_unselect{

  my(%ref) = @_;
##
  my $file = $ref{'file'};
  my $unselects = $ref{'unselects'};
  
 # if ($file eq "README") {return 1;}

  foreach my $unselect (@{$unselects}){
    return 1 if($file =~ /$unselect/);
  }
  return 0;
} ## check_unselect()

#######################################################################
## MODULE: new_file
## DESC: Generate new package file
##        'num'  => service number
##        'name' => package name(filename)

sub new_file{
  my($self) = shift if(defined($_[0]) && (ref($_[0]) ne ''));
  my(%ref) = @_;
##
  my $new = {};
  $new->{'num'} = $ref{'num'};
  $new->{'name'} = $ref{'name'};
  return $new;
} ## new_file()


#######################################################################
## MODULE: new_rcd


sub new_rcd{
  my($self) = shift if(defined($_[0]) && (ref($_[0]) ne ''));
  my(%ref) = @_;
##
  my @rcd = ();
  for ( my $i = 0; $i <= 7; $i++ ) {
    $rcd[$i] = '-01';       ## start
    $rcd[$i + 10] = '-01';  ## end
  }
  return \@rcd;
} ## new_rc()



#######################################################################
## MODULE: read_data


sub read_data{

  my(%ref) = @_;
##
  my $data = {};
##
 if ( open(IN, $ref{'file'}))
	{
  	while(<IN>){
    	next if ( /^\#/ );
	my ($first,$second,$third) = split;
			if (!defined($third)) {next;}
			if ($third =~ /([0-9][0-9])/){next;}	#corrects bug from v.1.2.7
      			$data->{$third}->{'start'} = $first;
      			$data->{$third}->{'stop'} = $second;

  	} ## while(<IN>)
  	close(IN);
       } ## if open IN
;
  return $data;
} ## read_data()

#######################################################################
## MODULE: select_default


sub select_default{
 
  my(%ref) = @_;
##
  my $rcdf = $ref{'rcdf'};
  my $data = $ref{'data'};
##
  my $link ;
  my @select = ();

  
  my $start_num; my $stop_num;
#  foreach my $package ( keys(%{$rcdf}) ) {
   foreach my $package (sort hashAscending (keys(%{$rcdf}))) {      #sort g_rcdf on RL2 priority
    $link = $rcdf->{$package}; 
    $start_num = $link->[2];
    $stop_num = $link->[11];
	$stop_num = $link->[10] if ($stop_num eq '-01'); #if there is no K in RL1, get the one in RL0

	#rule 1: S link in 2-3-4-5 AND S/K link in 1, AND K link in 0-6 (update-rc.d defaults)	
    if ( ( $start_num ne '-01' )   &&
         (($link->[1] ne '-01')  || ($link->[11] ne '-01')) &&
         ( $link->[3] ne '-01' ) &&
         ( $link->[4] ne '-01') &&
         ( $link->[5] ne '-01' ) &&
	 ($link->[10] ne '-01') &&
         ($link->[16] ne '-01') 
         ) {   
      		push(@select, $package);
        	$data->{$package}->{'start'} = $start_num;
        	$data->{$package}->{'stop'} = $stop_num;
        	next;
    		}

	#rule 2: S link in 2-3-4-5 AND K link in 1 (update-rc.d multiuser)    		
    if ( ( $start_num ne '-01' )   &&
         (($link->[1] ne '-01')  || ($link->[11] ne '-01')) &&
         ( $link->[3] ne '-01' ) &&
         ( $link->[4] ne '-01') &&
         ( $link->[5] ne '-01' )
         ) {   
      		push(@select, $package);
        	$data->{$package}->{'start'} = $start_num;
        	$data->{$package}->{'stop'} = $stop_num;
    		}
    		
    	
  	} ## foreach
 
  return \@select;
} ## select_default()
###########################################
## Sort routines

sub hashAscending{
  
   $g_rcdf->{$a}->[2] <=> $g_rcdf->{$b}->[2];
}

sub hashAscendingrcS{
  
   $g_rcdf->{$a}->[7] <=> $g_rcdf->{$b}->[7];
}

#################################################
# 
sub select_rcS
{
my(%ref) = @_;
##
  my $rcdf = $ref{'rcdf'};
  my $data = $ref{'data'};
##
  my $link ;
  my @rcSselect = ();

  
  my $start_num; my $stop_num;
   foreach my $package (sort hashAscendingrcS (keys(%{$rcdf}))) {      #sort g_rcdf on RcS priority
    next if ( &check_unselect(file=>$package, unselects=>\@unselects) );
    $link = $rcdf->{$package};    
    $start_num = $link->[7];
    $stop_num = $link->[10];
    if ( ( $start_num ne '-01' ) )
	{   
      push(@rcSselect, $package);
      #print STDERR "rcS....$package - $start_num\n";

        		$data->{$package}->{'start'} = $start_num;
			$data->{$package}->{'stop'} = $stop_num;
      			
    }
  } ## foreach

 
  return \@rcSselect;
} ## select_rcS()

##############################################
# get off scripts in rcS
#
sub init_rcSoff
{
	my(%ref) = @_;
  	my $rcdf = $ref{'rcdf'};

	my @rcSselect = ();
	my $link; my $stop_num;

	foreach my $package ( keys(%{$rcdf}) ) {
	$link = $rcdf->{$package};    
	$stop_num = $link->[17];
	 if ( ( $stop_num ne '-01' ) )
		{   
      		push(@rcSselect, $package);
      		#print STDERR "$package - $stop_num\n";
		}
	}

  return \@rcSselect;

}
#######################################################################
## MODULE: write_data


sub write_data{

  my(%ref) = @_;
##
  my $file = $ref{'file'};
  my $data = $ref{'data'};
  open(OUT, "> ".$file) || die "Cannot write file $file: $!";
  foreach my $key (keys(%{$data})){
   if ($data->{$key}->{'stop'}== -1) {$data->{$key}->{'stop'}= '-01';} 
   print OUT $data->{$key}->{'start'}." ".
      $data->{$key}->{'stop'}." ".
        $key."\n";
  #print STDERR "$data->{$key}->{'start'}  $data->{$key}->{'stop'} $key\n"; 
  }
  close(OUT);
} ## write_data()


#######################################################################
## MODULE: exec_update

sub exec_update{
  my($run_now,%ref) = @_;
##
  my $on = $ref{'on'};
  my $off = $ref{'off'};
  my $data = $ref{'data'};

##
  my $key;
  my $pn=0;



  foreach $key ( @{$on} ) {
		#update 'S' links
 		foreach my $rl(@cfg_levels) {
			update_link($key,$rl,'S',undef);
			}
		
		#update 'K' links (only if doesn't exist a K number saved)
		if (exists($data->{$key})) {
			if ($data->{$key}->{'stop'} == '-01') {
				$pn = 100 - $data->{$key}->{'start'};
				}
			}
		else {
			$pn=20;
			}		

		if ($pn !=0) {
  		foreach my $rl(@cfg_stoplevels) {
			update_link($key,$rl,'K',$pn);
				}
			}

		if ( ! -x $ETC_DIR . "/init.d/" . $key )
			{`chmod a+x $ETC_DIR/init.d/$key`;}
      		system("logger -t bum Activated service: $key");
      		if ( $run_now == 1 ) {
		 system($initd."/".$key." start".$DEBUG_STRING);
      			}
     }
   

foreach $key ( @{$off} ) {

 	#update start runlevels
	foreach my $rl (@cfg_levels) {
		update_link($key,$rl,'K',undef);
		}

	system("logger -t bum De-activated service: $key");
      	if ( $run_now== 1 ) {
		 system($initd."/".$key." stop".$DEBUG_STRING);
     		 }
  }

} ## exec_update()


#####################################################################
# the script is not in the human list: return UNDEF
# daemon is running: return TRUE
# daemon is NOT running return FALSE
# the script has no related daemons: return -1

sub check_if_running {

	my $key = shift;
	my $human=bum_init::get_human_text();
	if( exists $human->{$key} ){
		if ($key =~ 'apache') {return r_apache($human->{$key}->{daemon});}
		if (!$human->{$key}->{daemon}) {return -1;}			
		if (`ps -C $human->{$key}->{daemon} -o pid=`) {return TRUE;}		
		else {return FALSE;} 								
		}
	return undef;
}
#################################################
sub r_apache {
		my $daemon=shift;
		if ((`ps -C $daemon -o pid=`) || 
			(`ps -C httpd -o pid=`)    ||
			(`ps -C httpd2 -o pid=`)) 
						{return TRUE;}		
		else {return FALSE;} 								
}
################################################################
############################################################
sub get_current_runlevel
{
    if (-e $runlevel_cmd) {
        my $rl_out = `$runlevel_cmd`;
        $rl_out = 1 if $rl_out =~ /unknown/;
        $rl_out =~ /^\S\s?([Ss\d])?$/ or
            die "Unknown return from $runlevel_cmd : $rl_out";
        return $1;
    }
    else {
        return 1;
    }
}			
###############################################################

sub update_link
{
    my ($sn, $rl, $sk, $pri) = @_;

    if (defined $sn && defined $rl && defined $sk && defined $pri) {
        if (-e "$etc_rc$rl.d/$sk$pri$sn") {
            return 'exists';
        }
    }

    opendir (RL, "$etc_rc$rl.d") or die "$0: opendir $etc_rc$rl.d : $!";

    foreach (grep { /[SK]\d\d$sn/i } readdir(RL)) {
	unlink "$etc_rc$rl.d/$_"
	    or die "Can't unlink $etc_rc$rl.d/$_ : $!";
    }

	closedir(RL);

    # If we are completely deleting the link, $sk will
    # be empty.
    return 1 if $sk eq '';

    unless ($sk  =~ /^[SK]$/) { die "You have to use S or K to start a link" }


    if (!defined $pri) {
    	if ( exists($g_data->{$sn}) ) {
		    if ($sk eq 'S') {
			$pri=$g_data->{$sn}->{'start'};
			} #if 'S'
		    else {
			$pri=$g_data->{$sn}->{'stop'};
			if ($pri eq '-01') { 
				$pri = 100 -  $g_data->{$sn}->{'start'};
				}
			}#if 'K'
		}#if exists g_data
	else { #g_data does not exist
		$pri=20;
		}	
    }
	
	return if ($pri eq '-01');	#safeguard, maybe don't need
    if (length($pri)==1) {$pri = '0'.$pri;}

    unless ($pri =~ /^\d\d$/) { die "Priority isn't two numbers: $pri" }

    # unlike ln relative symlinks are relative to the target file, not the cwd
    symlink "../init.d/$sn", "$etc_rc$rl.d/$sk$pri$sn"
        or die "Can't symlink $etc_rc$rl.d/$sk$pri$sn to ../init.d/$sn : $!\n";
}

#########################################

sub check_lock{

	my @pids = `ps -C bum -o pid=`;
	
	if (scalar(@pids)>1) {return TRUE;}		
		else {return FALSE;} 	

}


1;
