##LNX-05 Users and groups

Linux heeft gebruikers, vergelijkbaar met accounts op Windows en MacOS. Elke gebruiker heeft zijn eigen homedirectory. Gebruikers kunnen ook deel uitmaken van groepen.
Er is een speciale gebruiker genaamd 'root'. Root mag alles doen.
Om tijdelijke root-rechten te krijgen, kun je 'sudo' typen voor een opdracht, maar dat werkt alleen als je dat mag doen. Voor sommige acties zijn (root)rechten vereist.
Gebruikers, wachtwoorden en groepen worden allemaal opgeslagen in (verschillende) bestanden verspreid over het systeem.

##Key-terms
Root user:
De rootgebruiker, ook bekend als de superuser, is een speciale gebruikersaccount in Linux die wordt gebruikt voor systeembeheer. Root user heeft vol-toegang op het Linux-systeem tot alle opdrachten en bestanden.
Root permissions:
De root permissions staan voor het hebben van volledige toestemming om elk bestand te lezen(r, read), te schrijven (w, write) en uit te voeren(x, execute).
sudo = "Super User DO"
sudo commando in Linux wordt over het algemeen gebruikt als een voorvoegsel van een commando dat alleen superuser mag uitvoeren. 

##Opdracht

	Maak een nieuwe user in uw VM.
	
	De nieuwe user moet deel uitmaken van een beheerdersgroep(admingroup) die ook de gebruiker bevat die u tijdens de installatie hebt gemaakt.
	
	De nieuwe user moet een wachtwoord hebben.
	
	De nieuwe user moet 'sudo' kunnen gebruiken.
	
	Zoek de bestanden waarin gebruikers, wachtwoorden en groepen worden opgeslagen. Kijk of u de gegevens van uw nieuw gemaakte gebruiker daar kunt vinden.

	![screenshot1]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx05/IMG_20211210_120416.jpg)
	![screenshot2]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx05/IMG_20211210_120506.jpg)


##Bronnen
https://www.youtube.com/watch?v=JTtE5Iy-0jI
https://linuxize.com/post/how-to-delete-users-in-linux-using-the-userdel-command/#:~:text=To%20delete%20users%20using%20the%20userdel%20command%2C%20you,command%20reads%20the%20content%20of%20the%20%2Fetc%2Flogin.defs%20file.
https://linoxide.com/add-user-sudoers-ubuntu/

##Problemen
Geen bijzonderheden

##Resultaat
Door het maken van deze opdracht begrijp ik het belang van het hebben van de juiste bevoegdheden (permissions), naar de aangewezen users of groups in het LinuxOS. Ik kan nu Users toevoegen en verwijderen, bevoegdheden aanpassen en het allemaal ongedaan maken wanneer dat nodig is.


