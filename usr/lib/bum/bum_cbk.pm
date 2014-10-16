
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
package  bum_cbk ;

use vars qw($application);

#################################
# Initialize the global variable
#################################
sub init {
my $app = shift ;
$application = $app;
}

###########################
# Display the about window
###########################


sub on_about_activate {
	my $auth1 = "Fabio Marzocca <thesaltydog\@gmail.com>";
	my $translator = _("translator-credits");
	($application->about_dlg)->set(
				authors=>$auth1, 
				version=>$application->version,
				name=>"Boot-Up Manager",
				copyright=>"Fabio Marzocca <thesaltydog\@gmail.com>",
				comments=>_('A graphical tool to handle runlevels configuration.'),
				website=>"http://www.marzocca.net/linux/bum.html",
				translator_credits=>$translator,
				logo => Gtk2::Gdk::Pixbuf->new_from_file($application->icon_path),
				license => _("This program is free software; you can redistribute it and/or
    	modify it under the terms of the GNU General Public License as 
    	published by the Free Software Foundation; either version 2 of 
    	the License, or (at your option) any later version.\n").
    	_("This program is distributed in the hope that it will be useful, 
    	but WITHOUT ANY WARRANTY; without even the implied warranty of 
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
    	General Public License for more details.\n").
	_("You should have received a copy of the GNU General Public License 
	along with this program; if not, write to the Free Software Foundation, Inc., 51 
	Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA"));
	$application->about_dlg->set_transient_for($application->window);
	$application->about_dlg->run;
	$application->about_dlg->hide;
}


##############################
### To quit the application
##############################

sub on_quit_btn_clicked {
	
	Gtk2->main_quit;
}


sub on_apply_btn_clicked {
	 
	my $ret="";
	
	my $messaggio = _("Start or stop services now? \n(If you answer No, changes will be applied at next boot.)");
  	my $dialog = Gtk2::MessageDialog->new ($application->window,
                               [qw/modal destroy-with-parent/],
			       'GTK_MESSAGE_QUESTION',
                    		'GTK_BUTTONS_YES_NO' ,
				$messaggio);
	$dialog->add_button('gtk-cancel','GTK_RESPONSE_CANCEL');

	$ret=$dialog->run;
	$dialog->destroy;
	bum_ops::bum_save($ret);	

	
}

sub on_notebook1_switch_page {
	#vedi change_page in bum
	($notebook, $pointer, $page) = @_;
	
	bum_ops::change_page($page);

}

sub on_adv_ck_toggled {
	
	my $ntbook=$application->notebook;
	
	$ntbook->set_current_page($application->SUM_PAGE) if ($ntbook->get_current_page > 0);
	$ntbook->set_show_tabs(!$ntbook->get_show_tabs);
}

sub on_start_service_now1_activate {

	bum_ops::start_now();	
}

sub on_stop_service_now1_activate {
	
	bum_ops::stop_now();
	
}

sub on_activate_apply_now1_activate{

	bum_ops::act_now();	
}


sub on_deactivate_apply_now1_activate{

	bum_ops::deact_now();	
}


sub on_priority1_activate{
	bum_ops::change_priority();
}

sub on_report_bum_activate {
	my ($report_dlg, $text_vw,$info_buffer,$urltag,$mark,$iter1);
	
	$report_dlg = $bum_app::uixml->get_object('report_dlg');
	$text_vw = $bum_app::uixml->get_object('textview_report');
	$info_buffer = $text_vw->get_buffer();
	$urltag = $info_buffer->create_tag ("url", weight => 700, wrap_mode_set => FALSE);
	$iter1 = $info_buffer->get_end_iter;
	$mark = $info_buffer->create_mark ("urlmark",$iter1, TRUE);
	$info_buffer->insert_with_tags($iter1,"http://wiki.ubuntu.com/InitScriptHumanDescriptions",$urltag);
	$report_dlg->set_transient_for($application->window);
	$report_dlg->run;
	$report_dlg->hide;
	$info_buffer->delete($iter1,$info_buffer->get_iter_at_mark($mark));
	$info_buffer->delete_mark($mark);
	$info_buffer->get_tag_table->remove($urltag);

	
}


1;
