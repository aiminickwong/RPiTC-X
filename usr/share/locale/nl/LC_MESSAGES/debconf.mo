��    E      D  a   l      �  o   �  ?   a  �   �  .   8  #   g     �  '   �     �     �     �       (        C  K   Z     �     �  -   �     �     �     �     	  8   	  M   V	  k   �	  8   
  (   I
     r
     w
  u   �
            X     @   o     �     �  ;   �  6     7   V  �   �  /     4   G  =   |  Y   �  �    )   �  7        :  1   Y  '   �  .   �  C   �     &  �   ?     �     �  n   �     V  @   o     �  &   �     �     �  '   	     1  !   J     l  a   �     �  j  �  |   Y  I   �  �      1   �  0        8  &   V     }     �     �     �  ,   �  "   �  T        r     y  C   �     �     �     �     �  ?     ]   P  j   �  ?     ,   Y     �  )   �  �   �     F     M  �   V  F   �     "  "   5  N   X  A   �  0   �  �     <   �  6   �  ?   (  �   h    �  (   !  8   *!     c!  0   �!  '   �!  .   �!  D   
"     O"  �   m"     #      #  |   2#  $   �#  R   �#  '   '$  *   O$     z$     ~$  -   �$  &   �$  '   �$  !   %  }   3%     �%        3      &       @                    <                       /                          =       )                  '       2   ;   +   9                 6   .   :   E      ?         ,      C   -   A           7       0                            *   1   "          B             8      $      5                  #   !   (   
      D      	   4   >   %    
        --outdated		Merge in even outdated translations.
	--drop-old-templates	Drop entire outdated templates. 
  -o,  --owner=package		Set the package that owns the command.   -f,  --frontend		Specify debconf frontend to use.
  -p,  --priority		Specify minimum priority question to show.
       --terse			Enable terse mode.
 %s failed to preconfigure, with exit status %s %s is broken or not fully installed %s is fuzzy at byte %s: %s %s is fuzzy at byte %s: %s; dropping it %s is missing %s is missing; dropping %s %s is not installed %s is outdated %s is outdated; dropping whole template! %s must be run as root (Enter zero or more items separated by a comma followed by a space (', ').) Back Choices Config database not specified in config file. Configuring %s Debconf Debconf on %s Debconf, running at %s Dialog frontend is incompatible with emacs shell buffers Dialog frontend requires a screen at least 13 lines tall and 31 columns wide. Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal. Enter the items you want to select, separated by spaces. Extracting templates from packages: %d%% Help Ignoring invalid priority "%s" Input value, "%s" not found in C choices! This should never happen. Perhaps the templates were incorrectly localized. More Next No usable dialog-like program is installed, so the dialog based frontend cannot be used. Note: Debconf is running in web mode. Go to http://localhost:%i/ Package configuration Preconfiguring packages ...
 Problem setting up the database defined by stanza %s of %s. TERM is not set, so the dialog frontend is not usable. Template #%s in %s does not contain a 'Template:' line
 Template #%s in %s has a duplicate field "%s" with new value "%s". Probably two templates are not properly separated by a lone newline.
 Template database not specified in config file. Template parse error near `%s', in stanza #%s of %s
 Term::ReadLine::GNU is incompatable with emacs shell buffers. The Sigils and Smileys options in the config file are no longer used. Please remove them. The editor-based debconf frontend presents you with one or more text files to edit. This is one such text file. If you are familiar with standard unix configuration files, this file will look familiar to you -- it contains comments interspersed with configuration items. Edit the file, changing any items as necessary, and then save it and exit. At that point, debconf will read the edited file, and use the values you entered to configure the system. This frontend requires a controlling tty. Unable to load Debconf::Element::%s. Failed because: %s Unable to start a frontend: %s Unknown template field '%s', in stanza #%s of %s
 Usage: debconf [options] command [args] Usage: debconf-communicate [options] [package] Usage: debconf-mergetemplate [options] [templates.ll ...] templates Valid priorities are: %s You are using the editor-based debconf frontend to configure your system. See the end of this document for detailed instructions. _Help apt-extracttemplates failed: %s debconf-mergetemplate: This utility is deprecated. You should switch to using po-debconf's po2debconf program. debconf: can't chmod: %s delaying package configuration, since apt-utils is not installed falling back to frontend: %s must specify some debs to preconfigure no none of the above please specify a package to reconfigure template parse error: %s unable to initialize frontend: %s unable to re-open stdin: %s warning: possible database corruption. Will attempt to repair by adding back missing question %s. yes Project-Id-Version: nl
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2014-04-22 20:04-0400
PO-Revision-Date: 2010-03-08 18:53+0100
Last-Translator: Frans Pop <elendil@planet.nl>
Language-Team: Dutch <debian-l10n-dutch@lists.debian.org>
Language: nl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
 
        --outdated		Ook verouderde vertalingen invoegen.
        --drop-old-templates	Verouderde sjablonen laten vervallen. 
  -o,  --owner=pakket		Pakket dat eigenaar is van de opdracht instellen.   -f,  --frontend		Te gebruiken debconf interface specificeren.
  -p,  --priority		Minimum prioriteit voor te tonen vragen specificeren.
       --terse			Beknopte modus aanzetten.
 voorconfigureren van "%s" mislukt met foutcode %s %s is beschadigd of niet volledig geïnstalleerd %s is 'fuzzy' bij byte %s: %s %s is 'fuzzy' bij byte %s: %s; vervalt %s ontbreekt %s ontbreekt; %s vervalt %s is niet geïnstalleerd %s is verouderd %s is verouderd; de gehele sjabloon vervalt! %s moet als root worden uitgevoerd (Geef nul of meer waarden, gescheiden door een komma gevolgd door een spatie (', '.) Vorige Keuzen Configuratiedatabase is niet gespecificeerd in configuratiebestand. Bezig met configureren van %s Debconf Debconf op %s Debconf, draaiend op %s De dialoog-interface is niet compatibel met emacs-shell-buffers De dialoog-interface vereist een scherm dat tenminste 13 regels hoog en 31 kolommen breed is. De dialoog-interface werkt niet op een domme terminal, een emacs-shell-buffer of zonder sturende terminal. Geef de waarden die u wilt selecteren, gescheiden door spaties. Extraheren van sjablonen uit pakketten: %d%% Help Ongeldige prioriteit "%s" wordt genegeerd Invoerwaarde "%s" niet gevonden in toegestane waarden voor C! Dit zou nooit mogen gebeuren. Mogelijk zijn de sjablonen niet juist gelocaliseerd. Verder Volgende Er is geen bruikbaar dialoog-achtig programma geïnstalleerd; hierdoor kan de op dialogen gebaseerde interface niet worden gebruikt. Let op: Debconf draait in internet-modus. Ga naar http://localhost:%i/ Pakketconfiguratie Voorconfigureren van pakketten...
 Probleem bij het instellen van de database gedefinieerd door stanza %s van %s. TERM is niet gezet; hierdoor is de dialoog-interface onbruikbaar. Sjabloon #%s in %s bevat geen 'Template:'-regel
 Sjabloon #%s in %s bevat veld "%s" dubbel met als nieuwe waarde "%s". Waarschijnlijk zijn twee sjablonen niet juist gescheiden door een enkele witregel.
 Sjabloondatabase niet gespecificeerd in configuratiebestand. Fout bij het ontleden nabij "%s" in stanza #%s van %s
 Term::ReadLine::GNU is niet compatibel met emacs shell buffers. De opties m.b.t. 'Sigils' en 'Smileys' in het configuratiebestand worden niet langer gebruikt. U wordt verzocht deze te verwijderen. De op een editor gebaseerde interface presenteert u met één of meerdere tekstbestanden die u kunt wijzigen. Dit is één van die bestanden. Als u bekend bent met standaard configuratiebestanden in Unix, zal dit bestand u bekend voorkomen -- het bevat commentaar met daartussen configuratieregels. Wijzig waar nodig de configuratieregels in het bestand, sla het vervolgens op en sluit de editor af. Vervolgens zal debconf het gewijzigde bestand inlezen en de waarden die u heeft ingevoerd gebruiken om het systeem te configureren. Deze interface vereist een sturende tty. Kan Debconf::Element::%s niet laden. Mislukt vanwege: %s Kan geen interface starten: %s Onbekend sjabloonveld "%s" in stanza #%s van %s
 Usage: debconf [opties] opdracht [args] Gebruik: debconf-communicate [opties] [pakket] Gebruik: debconf-mergetemplate [opties] [sjablonen.ll ...] sjablonen Geldige prioriteiten zijn: %s U gebruikt de op een editor gebaseerde debconf-interface om uw systeem te configureren. Raadpleeg het einde van dit document voor gedetailleerde instructies. _Help apt-extracttemplates mislukt: %s debconf-mergetemplate: Dit hulpprogramma is verouderd. U kunt beter het programma po2debconf (pakket: po-debconf) gebruiken. debconf kan chmod niet uitvoeren: %s configuratie van pakketten wordt uitgesteld omdat apt-utils niet is geïnstalleerd er wordt teruggevallen op interface: %s geen debs opgegeven om te voorconfigureren nee geen van bovenstaande geef een pakket in om opnieuw te configureren fout bij het ontleden van sjabloon: %s kan de interface niet initialiseren: %s kan stdin niet opnieuw openen: %s waarschuwing: database is mogelijk beschadigd. Zal proberen deze te repareren door ontbrekende vraag "%s" weer toe te voegen. ja 