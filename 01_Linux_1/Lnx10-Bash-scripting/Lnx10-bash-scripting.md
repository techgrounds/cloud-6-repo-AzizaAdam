## Bash scripting

## Introductie

De standaard opdrachtregelinterface in Linux wordt een Bash-shell genoemd. Je hebt al interactie gehad met Linux met behulp van opdrachten in deze shell.
Een Bash-script is een reeks opdrachten die in een tekstbestand zijn geschreven. U kunt meerdere opdrachten achter elkaar uitvoeren door alleen het script uit te voeren.
Extra logica kan worden toegepast met onder andere het gebruik van variabelen, voorwaarden en lussen.

Om het script te kunnen uitvoeren, moet een gebruiker machtigingen hebben om het bestand (x) uit te voeren.
Linux kan het script alleen vinden als je de padnaam opgeeft, of als je het pad toevoegt aan de map waarin het script zich bevindt aan de variabele PATH.

Hint: hoewel er geen bestandsextensies zijn in Linux, is het voor mensen gemakkelijker te begrijpen als je je scriptnamen beëindigt met '.sh'.


## Key-terms:
Random Generator:
Willekeurige generator
PATH variable:
De PATH variable map word door het OS gecontrolleerd om het programma te draaien die is aangemaakt. Hiermee kun je jouw eigen programmas die in een map zitten draaien zonder het pad steeds opnieuw in te voeren.
UWF:
Uncomplicated Firewall - Is een simpele firewall voor het linux OS om makkelijk toegang te geven of toegang te negeren/blokkeren, op basis van regels die je kunt stellen.


## Opdracht1:
Maak een map met de naam 'scripts'. Plaats alle scripts die je maakt in deze map.
Voeg de scriptmap toe aan de PATH-variabele.
Maak een script dat een regel tekst aan een tekstbestand toevoegt wanneer het wordt uitgevoerd.
Maak een script dat het httpd-pakket installeert, httpd activeert en httpd inschakelt. Ten slotte zou je script de status van httpd in de terminal moeten afdrukken.
Variabelen:
U kunt een waarde toewijzen aan een tekenreeks, zodat de waarde ergens anders in het script kan worden gelezen.
Het toekennen van een variabele doe je met ‘=’.
Het lezen van de waarde van een variabele doe je met ‘$<insert variable name here>’.

![scripts-directory]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/Create%20scripts%20directory.jpg)

![add-script-to-a-PATH-var]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/add%20scripts%20directory%20to%20PATH%20var.jpg)

![script-appends-a-line]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/create%20script%20to%20append%20a%20line%20in%20txt%20file.jpg)

![script-to-install-httpd]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/script%20to%20install%20httpd.jpg)

![httpd-is-running]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/httpd%20is%20running%20and%20active.jpg)

## Opdracht2:
Maak een script dat een willekeurig getal tussen 1 en 10 genereert, dit opslaat in een variabele en het getal vervolgens aan een tekstbestand toevoegt.
Conditie:
U kunt ervoor kiezen om alleen delen van uw script uit te voeren als aan een bepaalde voorwaarde is voldaan. Lees bijvoorbeeld alleen een bestand als het bestand bestaat, of schrijf alleen naar een logboek als de statuscontrole een fout retourneert. Dit kan aan de hand van voorwaarden.
Een controle op een voorwaarde kan met ‘if’, ‘elif’ en/of ‘else’.

![script-random-number-gen]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/script%20random%20number%20generator.jpg)



## Opdracht3:
Maak een script dat een willekeurig getal tussen 1 en 10 genereert, het opslaat in een variabele en het getal vervolgens alleen aan een tekstbestand toevoegt als het getal groter is dan 5. Als het getal 5 of kleiner is, moet er een regel aan worden toegevoegd van tekst naar datzelfde tekstbestand in plaats daarvan.

![script-random-number-gen-euqal-bigger-than-5-in-txt-file]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Lnx10/script%20to%20add%20random%20number%20higher%20than%205%20to%20txt%20file.jpg)



## Bronnen
https://www.youtube.com/watch?v=YAY0gTTydvg
https://www.youtube.com/watch?v=3BLr-vnzpSQ
https://linuxize.com/post/how-to-add-directory-to-path-in-linux/
https://stackoverflow.com/questions/1262903/add-to-file-if-exists-and-create-if-not
https://appuals.com/set-bash-variables-random-numbers/
https://stackoverflow.com/questions/8988824/generating-random-number-between-1-and-10-in-bash-shell-script
https://linuxize.com/post/bash-if-else-statement/


## Problemen
Nog moet meer info zoeken om Bash-scripting goed te kunnen begrijpen. Deze file is nog onder editing!


## Resultaat
Zie screenshots bovenaan.


