## File permissions

## Introductie
Elk bestand in Linux bevat een reeks machtigingen. Er zijn aparte rechten voor het ( r ) lezen, ( w ) schrijven en ( x ) uitvoeren van bestanden (rwx). Er zijn ook drie soorten machtigingen kunnen hebben: de eigenaar van het bestand (owner), een groep (group) en alle anderen (others). 
U kunt de machtigingen van een bestand bekijken door een lange lijst te maken. De machtigingen van een bestand, evenals de eigenaar en groep, kunnen ook worden gewijzigd.
Elke gebruiker vermeld in /etc/passwd kan worden toegewezen als eigenaar van een bestand.
Elke groep in /etc/group kan worden toegewezen als de groep van een bestand.

## Key-terms

Chmod:
Commando om de rechten tot bestanden en moppen te veranderen.

## Opdracht:
Maak een tekstbestand.
Maak een lange lijst om de machtigingen van het bestand te bekijken. Wie is de eigenaar en groep van het bestand? Welke machtigingen heeft het bestand?
Maak het bestand uitvoerbaar door de uitvoermachtiging (x) toe te voegen.
Verwijder de lees- en schrijfrechten (rw) uit het bestand voor de groep en alle anderen, maar niet voor de eigenaar. Kun je het nog lezen?
Wijzig de eigenaar van het bestand in een andere gebruiker. Als alles goed is gegaan, zou je het bestand niet moeten kunnen lezen, tenzij je root-privileges aanneemt met 'sudo'.
Wijzig het groepseigendom van het bestand in een andere groep.

![screenshot1]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx06/IMG_20211208_232553.jpg)
![screenshot2]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx06/IMG_20211208_232724.jpg)
![screenshot3]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx06/IMG_20211208_233845.jpg)


## Bronnen
https://www.youtube.com/watch?v=JTtE5Iy-0jI
https://www.edx.org/course/introduction-to-linux



## Problemen
Geen bijzonderheden


## Resultaat
Door het maken van deze opdracht begrijp ik het belang van het hebben van de juiste bevoegdheden (permissions), naar de aangewezen users of groups in het LinuxOS. 


