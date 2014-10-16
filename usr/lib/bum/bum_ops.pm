#!/usr/bin/perl -w

############################################################################
#    Copyright (C) 2005 by Fabio Marzocca                             #
#    thesaltydog@gmail.com                                                 #
#                                                                          #
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
############################################################################


# -----------------------------------------------------------------
package  bum_ops ;

use strict ;
use Encode ;
use vars qw($application);
use Glib qw(TRUE FALSE);
use Gtk2::SimpleList;


## summary treeview
use constant {
	SUM_TOGGLE		=>	0,
	SUM_DESCR		=>	1,
	SUM_PIXBUF		=>	2,
};

##standardRL model
use constant {
	STA_TOGGLE		=>	0,
	STA_SERVICE		=>	1,
	STA_SINGLEUSER		=>	2,
	STA_RL2			=>	3,
	STA_RL3			=>	4,
	STA_RL4			=>	5,
	STA_RL5			=>  	6,
	STA_REBOOT		=>	7,
	STA_HALT		=>	8,
	STA_PIXBUF		=>	9,
	STA_DESCR		=>	10,
	STA_RUNORDER		=>	11,
	DELTA_RL		=>	1,
};

#rcSd model
use constant {
	RCS_TOGGLE		=>	0,
	RCS_SCRIPT		=>	1,
	RCS_RLS			=>	2,
	RCS_REBOOT		=>	3,
	RCS_HALT		=>	4,
};

my $pxbf_boh; 
my $pxbf_on;
my $pxbf_off;
my $pxbf_none;
#################################
# Initialize the global variable
#################################
sub init {
	my $app = shift ;
	$application = $app;
	
	my $pixdir = File::Spec->catdir(bum_Config->DATADIR, 'pixmaps');
	$pxbf_boh = Gtk2::Gdk::Pixbuf->new_from_file
				($pixdir.'/bum_serv_boh.png');
	$pxbf_on=Gtk2::Gdk::Pixbuf->new_from_file
				($pixdir.'/bum_serv_on.png');
	$pxbf_off=Gtk2::Gdk::Pixbuf->new_from_file
				($pixdir.'/bum_serv_off.png');
	$pxbf_none=Gtk2::Gdk::Pixbuf->new_from_file
				($pixdir.'/bum_serv_none.png');

}
###########################################

sub message
{
    
  my ($messaggio,$icon)= @_; 
  my $dialog = Gtk2::MessageDialog->new (
		$application->window,
        [qw/modal destroy-with-parent/],
		$icon,
        'GTK_BUTTONS_OK',
		$messaggio);
  $dialog->set_markup($messaggio);
  if ('ok' eq $dialog->run) {$dialog -> destroy;}
    else {;}
  $dialog->destroy;   

} 	

####################################
# The summary treeview
#
# This Gtk2::Treeview shares the same model
# set in standardRL page (SimpleList)
#####################################
sub create_summary_treeview{
	my $treeview=shift;


	#first column. Toggle checkbox
	$treeview->insert_column_with_attributes(
				 SUM_TOGGLE,_('Activate'),
				Gtk2::CellRendererToggle->new, 
				active => STA_TOGGLE);
				
	#second column. Service & Description.
	$treeview->insert_column_with_attributes(
				SUM_DESCR,_('Description'),
				Gtk2::CellRendererText->new,
				markup => STA_DESCR);
	
	#third column. Pixbuf.
	$treeview->insert_column_with_attributes(
				SUM_PIXBUF,_('Running'),
				Gtk2::CellRendererPixbuf->new,
				pixbuf	=> STA_PIXBUF);
				
	
	foreach my $col ($treeview->get_columns) {
		$col->set_clickable(TRUE);
		}		

	$treeview->get_column(SUM_TOGGLE)->set_sort_column_id(STA_TOGGLE);
	$treeview->get_column(SUM_DESCR)->set_sort_column_id(STA_SERVICE);
	$treeview->get_column(SUM_PIXBUF)->set_sort_column_id(STA_RUNORDER);	
	$treeview->get_column(SUM_DESCR)->set_resizable(TRUE);
	
	$treeview->signal_connect(button_press_event => sub {
					
			my ($widget, $event) = @_;					
			my ($path, $column) = $widget->get_path_at_pos ($event->coords);	
			return TRUE if (!defined($path));
			$widget->get_selection->select_path ($path);				
			if ($event->button==1) { #tasto sinistro
				if ($column == $treeview->get_column(SUM_TOGGLE)) { #allinea la variazione su $defaultRL 
					my $ind = ($path->get_indices)[0];
					$application->standardRL->{data}[$ind][STA_TOGGLE]^= 1;
					}
				}
			if ($event->button==3) { #tasto destro
				bum_popupmenu($event,$treeview);
				}
			return FALSE;});
			
     $treeview->signal_connect(cursor_changed=> sub {
		   			check_menu_sens();
		   			});
					

					
	#connect to STANDARD model
	my $mdl = $application->standardRL->get_model();
	$treeview->set_model($mdl);					
	return $treeview;
}

########################################
#  Standard RL treeview
#######################################
sub create_standardRL_treeview{
	my $treeview=shift;
	my $i;
	
	my $slist = Gtk2::SimpleList->new_from_treeview(
			$treeview,
           	_('Activate')		=>	'bool',
           	_('Service name')	=>	'text',
		_('Single user')	=>	'text',
		'Run level 2'		=>	'text',
		'Run level 3'		=>	'markup',
		'Run level 4'		=>	'text',
		'Run level 5'		=>	'text',
		'Reboot'		=>	'text',
		'Halt'			=>	'text',
		_('Running')		=>	'pixbuf', 	#pixbuf
		''			=>	'hidden',	#description
		''			=>	'hidden',	#run_order
            );
	
	my $rl = bumlib::get_current_runlevel();
	
	my $rl_column =$slist->get_column($rl+DELTA_RL);
	$rl_column->set_title($rl_column->get_title()."*");
	
	#center the columns
	for (my $column_index=2; $column_index<=7; $column_index++) {
	        my $cell = (
				$slist->get_column($column_index)->
										get_cell_renderers)[0];
			$cell->set(xalign=>0.5);
		}

	$slist->signal_connect(button_press_event => sub {
			my ($widget, $event) = @_;					
			my ($path, $column) = $widget->get_path_at_pos ($event->coords);	
			return TRUE if (!defined($path));
			$widget->get_selection->select_path ($path);				
			if ($event->button==1) { #tasto sinistro
								}
			if ($event->button==3) { #tasto destro
				bum_popupmenu($event,$slist);
				}
			return FALSE;
		});

	$slist->signal_connect(cursor_changed=> sub {check_menu_sens(); });
	
	$i=0;
	foreach my $col ($slist->get_columns) {
			$col->set_clickable(TRUE);
			$col->set_sort_column_id($i);
			$i++;
		}

	$slist->get_column(STA_PIXBUF)->set_sort_column_id(STA_RUNORDER);	

	return $slist;
}

sub populate_standardRL {
	my ($array_element, $sta_mdl,$iter);
	my $scripts = $application->standardRL;
	my $summary = $application->summary;
	
	splice(@{$scripts->{data}});

	$sta_mdl = $scripts->get_model();
	my $list=bumlib::get_full_list();
	
	foreach $array_element(@$list)
	{
		Gtk2->main_iteration while ( Gtk2->events_pending );
        	my ($toggle,$service,$halt,$single,$rl2,$rl3,$rl4,$rl5,$reboot)
					=split(/,/,$array_element);
		#get package description		
		my ($info) = bumlib::get_summ_info($service);
		my ($pixbuf, $run_order) = get_status_pxbf($service);
		
		#fill main model
		$iter = $sta_mdl->append;
		$sta_mdl->set($iter,
			STA_TOGGLE,$toggle,
			STA_SERVICE,$service,
			STA_HALT,$halt,
			STA_SINGLEUSER,$single,
			STA_RL2,$rl2,
			STA_RL3,$rl3,
			STA_RL4,$rl4,
			STA_RL5,$rl5,
			STA_REBOOT,$reboot,
			STA_DESCR, "<span size='large'><b>$info</b></span>\n$service",
			STA_PIXBUF, $pixbuf,
			STA_RUNORDER, $run_order
			);	
					
	}
  $scripts->select(0);
  $iter = $sta_mdl->iter_nth_child(undef,0);
  $summary->get_selection->select_iter($iter);
}

sub get_status_pxbf {

	my $key = shift; #script name

 	my $running = bumlib::check_if_running($key);
	if (!defined($running)) {return ($pxbf_boh,0);}
	if ($running==TRUE) {	return ($pxbf_on,3);}
	elsif($running==FALSE) {return ($pxbf_off,2);}
	elsif($running==-1) {return ($pxbf_none,1);}

}



#################################

sub check_menu_sens {
	my ($servicecol, $page);
	my $item= get_current_row();
	
	$page = $application->notebook->get_current_page;
	
	if ($page ==$application->SUM_PAGE) { $servicecol = STA_SERVICE; }
	if ($page ==$application->STA_PAGE) { $servicecol = STA_SERVICE; }
	if ($page ==$application->RCS_PAGE) { $servicecol = RCS_SCRIPT; }

	

	if ($item->[0]) { #service is active
	    $bum_app::uixml->get_object('activate_apply_now1')->set_sensitive(FALSE);
		$bum_app::uixml->get_object('deactivate_apply_now1')->set_sensitive(TRUE);
		if ($page==$application->STA_PAGE) {
			$bum_app::uixml->get_object('priority1')->set_sensitive(TRUE);
			}  
		}
	else { #service is deactived
		$bum_app::uixml->get_object('activate_apply_now1')->set_sensitive(TRUE); #activate
		$bum_app::uixml->get_object('deactivate_apply_now1')->set_sensitive(FALSE);
		$bum_app::uixml->get_object('priority1')->set_sensitive(FALSE);
	}

	my $running = bumlib::check_if_running($item->[$servicecol]);
		
	if (!defined($running)) {
		$bum_app::uixml->get_object('start_service_now1')->set_sensitive(TRUE);  #start service
		$bum_app::uixml->get_object('stop_service_now1')->set_sensitive(TRUE);  #stop service
	}
	elsif ($running==TRUE) { 
		$bum_app::uixml->get_object('start_service_now1')->set_sensitive(FALSE);  #start service
		$bum_app::uixml->get_object('stop_service_now1')->set_sensitive(TRUE);  #stop service
	}
	elsif($running==FALSE){
		$bum_app::uixml->get_object('start_service_now1')->set_sensitive(TRUE);  #start service
		$bum_app::uixml->get_object('stop_service_now1')->set_sensitive(FALSE);  #stop service
	}
	elsif($running==-1){
		$bum_app::uixml->get_object('start_service_now1')->set_sensitive(FALSE);  #start service
		$bum_app::uixml->get_object('stop_service_now1')->set_sensitive(FALSE);  #stop service
	}

	set_info_text() if ($page != $application->SUM_PAGE);
}

##############################
sub start_progress
{
	my $prog_win = $bum_app::uixml->get_object('prog_win');
	my $prog_bar = $bum_app::uixml->get_object('progressbar1');
	$prog_bar->pulse();
	$prog_win->set_icon(Gtk2::Gdk::Pixbuf->new_from_file($application->icon_path));
	$prog_win->set_transient_for($application->window);
	$prog_bar->{activity_mode} = 1;
	$prog_bar->{timer} = Glib::Timeout->add(100, \&progress_timeout, $prog_bar);
	
	$prog_win->show;
	return ($prog_bar);
}

sub progress_timeout
{
	my $pbar = shift;
		$pbar->pulse;
	return TRUE;
}

# Remove the timer
sub destroy_progress
{
	my $pbar = shift;
	Glib::Source->remove($pbar->{timer});
	
	$bum_app::uixml->get_object('prog_win')->destroy;
		
	}


##################################
# rcSd treeview
####################################


sub create_rcSd_treeview{
	my $treeview=shift;
	my $i;
	
	my $rcS = Gtk2::SimpleList->new_from_treeview(
			$treeview,
  	        _('Activate')    => 'bool',
            _('Script name')  => 'text',
			'Run level S'	=>	'text',
			'Reboot'	=>	'text',
			'Halt'	=>	'text'
            );

	#make inactive the checkboxes
	my $cellrend=($rcS->get_column(RCS_TOGGLE)->get_cell_renderers)[0];
	$cellrend->set('activatable',FALSE);

	#center the columns
	for (my $column_index=2; $column_index<=3; $column_index++) {
	        my $cell = ($rcS->get_column($column_index)->get_cell_renderers)[0];
			$cell->set(xalign=>0.5);
		}

	$rcS->signal_connect(button_press_event => sub {
					my ($widget, $event) = @_;					
					if ( $event->button == 1) {
						my ($path, $column) = $widget->get_path_at_pos ($event->coords);
						return TRUE if (!defined($path));
						message ("<b>"._("Editing in run level S is not allowed!").
								 "</b>\n".
								 _("Playing with rcS.d symlinks is an administration activity requiring deep knowledge of the runlevel system."),
								'GTK_MESSAGE_INFO') 
									if ($column == $rcS->get_column(RCS_TOGGLE));
					}	
						
					return FALSE;});

					

	$rcS->signal_connect(cursor_changed=> sub {check_menu_sens(); });

	$i=0;
	foreach my $col ($rcS->get_columns) {
			$col->set_clickable(TRUE);
			$col->set_sort_column_id($i);
			$i++;
		}
	return $rcS;
}


sub populate_rcSd {
	my ($array_element,$iter,$mdl); 
	my $list="";
	my $rcS = $application->rcSd;
	
	splice(@{$rcS->{data}});	
	$mdl = $rcS->get_model;
	$list=bumlib::get_full_rcS_list();	
	foreach $array_element(@$list)
	{
		Gtk2->main_iteration while ( Gtk2->events_pending );
        my ($toggle,$service,$halt,$rlS,$reboot)
						=split(/,/,$array_element);
		$iter = $mdl->append;
		$mdl->set ($iter,
			RCS_TOGGLE,$toggle,
			RCS_SCRIPT,$service,
			RCS_HALT,$halt,
			RCS_RLS,$rlS,
			RCS_REBOOT,$reboot
			);
	}
   	$rcS->select(0);
}

sub set_info_text
{
	#set info text
	my $buffer="";
	my ($key,$page);
	my $item= get_current_row();
	
	$page = $application->notebook->get_current_page;
	if ($page==$application->STA_PAGE) {	
		$buffer = $application->info_b_standard;
		$key = $item->[STA_SERVICE];
		}
	if ($page==$application->RCS_PAGE) {
		$buffer = $application->info_b_rcS; 
		$key = $item->[RCS_SCRIPT];
		}

	my ($pkg,$info) = bumlib::new_get_script_info($key);

	$buffer->delete($buffer->get_start_iter,$buffer->get_end_iter);
  	$buffer->insert($buffer->get_start_iter,$key.": ".$pkg."\n\n");
	$buffer->apply_tag_by_name ('title', $buffer->get_start_iter, $buffer->get_end_iter);
  	$buffer->insert($buffer->get_end_iter,decode_utf8($info));
	
}

sub get_current_row
{
	my (@list,$page,$ind);
	$page = $application->notebook->get_current_page;
	
	if ($page==$application->STA_PAGE) { 
		$ind= ($application->standardRL->get_selected_indices)[0];
		return undef unless defined $ind;
		return $application->standardRL->{data}[$ind];
		}
	elsif($page==$application->RCS_PAGE) {
		$ind= ($application->rcSd->get_selected_indices)[0];
		return undef unless defined $ind;
		return $application->rcSd->{data}[$ind];
		}
	elsif($page==$application->SUM_PAGE) {
		my $selection= $application->summary->get_selection;
		return undef unless $selection;
		my $path=($selection->get_selected_rows)[0];
		$ind = ($path->get_indices)[0];		
		return $application->standardRL->{data}[$ind];
		}
	
	return undef;

}

sub change_page
{
	my $page = shift;
		set_info_text() if ($page != 0);
		
	if  ($page==$application->SUM_PAGE){		
		$bum_app::uixml->get_object('applica1')->set_sensitive(TRUE);
		$bum_app::uixml->get_object('apply_btn')->set_sensitive(TRUE);
		$bum_app::uixml->get_object('services1')->set_sensitive(TRUE);
		$bum_app::uixml->get_object('priority1')->set_sensitive(FALSE);      
	}
	elsif ($page ==$application->RCS_PAGE) {
		$bum_app::uixml->get_object('services1')->set_sensitive(FALSE);
		$bum_app::uixml->get_object('applica1')->set_sensitive(FALSE);
		$bum_app::uixml->get_object('apply_btn')->set_sensitive(FALSE);
	}
 	elsif ($page == $application->STA_PAGE) {
		$bum_app::uixml->get_object('applica1')->set_sensitive(TRUE);
		$bum_app::uixml->get_object('apply_btn')->set_sensitive(TRUE);
		$bum_app::uixml->get_object('services1')->set_sensitive(TRUE);
		check_menu_sens();
	}
}

sub bum_popupmenu
{
	my ($event, $slist)= @_; 
	my ($page,$toggle,$servname,$ind);
	
	$page = $application->notebook->get_current_page;
	

	if ($page==$application->SUM_PAGE) {
		my $selection= $slist->get_selection;
		my $path=($selection->get_selected_rows)[0];
		$ind = ($path->get_indices)[0];		
		}
	
	if ($page ==$application->STA_PAGE) {
		$ind= ($slist->get_selected_indices)[0];
		}
		
		
	$toggle = $application->standardRL->{data}[$ind][STA_TOGGLE];
	$servname = $application->standardRL->{data}[$ind][STA_SERVICE];
	
		
	my $pmenu = Gtk2::Menu->new;

    my $deact= Gtk2::MenuItem->new (_("Deactivate & apply now"));
    my $act= Gtk2::MenuItem->new (_("Activate & apply now"));
	my $priority= Gtk2::MenuItem->new (_("Change start/stop priority"));
	my $separator = Gtk2::MenuItem->new ();
	my $stop = Gtk2::MenuItem->new (_("Stop now"));
	my $start = Gtk2::MenuItem->new (_("Start now"));	
 	
	$stop->signal_connect(activate=>sub{stop_now();	});
	$start->signal_connect(activate=>sub{start_now();});
	$deact->signal_connect(activate=>sub{deact_now();});
	$act->signal_connect(activate=>sub{act_now();});
	$priority->signal_connect(activate=>sub{change_priority();});
	
	if ($toggle) {
		if ($page ==$application->STA_PAGE) {
			$pmenu->add($priority);
			$priority->show;	
			$pmenu->append ($separator);
			$separator->show;		
		}
		$pmenu->add($deact);
		$deact->show;
		}
	else {
		$pmenu->add($act);
		$act->show;
		}
		
	
	my $running= bumlib::check_if_running($servname);
	if (!defined($running)) {
		$pmenu->add($stop);
		$stop->show;
		$pmenu->add($start);
		$start->show;
		}
	elsif ($running==TRUE) {
		$pmenu->add($stop);
		$stop->show;
		}
	elsif($running==FALSE) {	
		$pmenu->add($start);
		$start->show;
		}
	$pmenu->popup (undef,undef,undef,undef, $event->button, $event->time);
	

return TRUE;

	
	
}


sub stop_now
{
	my $servname;
	
	my $item= get_current_row();
	my $page = $application->notebook->get_current_page;
	
	if (!defined $item) {
		message(_("You must select a script before!"));
		return;
		}
	
	$servname = $item->[STA_SERVICE];

		
	my $msg=bumlib::stop_service($servname); 
	if ($msg==0) {
		message(_("Service  stopped."),'GTK_MESSAGE_INFO');
		}
	else {
		message(_("Failed command execution."),'GTK_MESSAGE_ERROR');
		}
 
	populate_standardRL(); 
}

sub start_now
{
	my $servname;
	
	my $item= get_current_row();
	if (!defined $item) {
		message(_("You must select a script before!"));
		return;
		}

	my $page = $application->notebook->get_current_page;
	$servname = $item->[STA_SERVICE];
		
	my $msg=bumlib::start_service($servname); 
	if ($msg==0) {
		message(_("Service  started."),'GTK_MESSAGE_INFO');
		}
	else {
		message(_("Failed command execution."),'GTK_MESSAGE_ERROR');
		}
	populate_standardRL(); 
}


sub act_now
{
	
	my $item= get_current_row();

	if (!defined $item) {
		message(_("You must select a script before!"));
		return;
		}
		
	
	$item->[STA_TOGGLE]=1;
	bum_save('yes');
}


sub deact_now
{
	my $item= get_current_row();

	if (!defined $item) {
		message(_("You must select a script before!"));
		return;
		}

	$item->[STA_TOGGLE]=0;
	bum_save('yes');
}

sub bum_save
{
	my $ret = shift;
	#hour-glass
	$application -> window->window -> set_cursor(Gtk2::Gdk::Cursor -> new("watch"));
   	Gtk2->main_iteration while (Gtk2->events_pending); 			
	
	bumlib::make_changes($application->standardRL->{data},$ret);
	populate_standardRL();

	#restore pointer
	$application -> window->window -> set_cursor(Gtk2::Gdk::Cursor -> new("left-ptr"));

}



sub change_priority {
	
	my ($priority_dlg, $service_label, $serv_name, $start_pri, $stop_pri, $start_spin,$stop_spin);
	my $item= get_current_row();
	
	$priority_dlg = $bum_app::uixml->get_object('priority_dlg');
	$service_label = $bum_app::uixml->get_object('priority_label');
	$start_spin = $bum_app::uixml->get_object('start_spin');	
	$stop_spin = $bum_app::uixml->get_object('stop_spin');
	$priority_dlg->set_transient_for($application->window);
	
	$serv_name = $item->[STA_SERVICE];
	$service_label->set_markup("<span foreground='red'><b>".
					$serv_name.
					"</b></span>");
	
	$start_pri = $item->[STA_RL2];
	$start_pri =~ s/S//g;
	$start_pri = 20 if ($start_pri !~ /^([0-9][0-9])/);
	$start_spin->set_value($start_pri);
	
	$stop_pri = $item->[STA_HALT];
	$stop_pri =~ s/K//g;
	$stop_pri = 20 if ($stop_pri !~ /^([0-9][0-9])/) ;
	$stop_spin->set_value($stop_pri);
	
	
	$priority_dlg->show;
	
	if ('ok' eq $priority_dlg->run) {
				$priority_dlg -> hide;
				bumlib::service_priority($serv_name,
										 $start_spin->get_value,
										 $stop_spin->get_value) ;
				populate_standardRL();
				}
    		else {;}
    
	$priority_dlg->hide  

	
	
}

sub check_if_lock
{

	my  $ret = bumlib::check_lock();
	if ($ret) {
		message(_("An instance of BUM is already running!"),'GTK_MESSAGE_ERROR');
		}
	return $ret;		
}


sub bum_col_clicked {

	my $col = shift;

	#$col->set_sort_column_id(1);	
}


1;
