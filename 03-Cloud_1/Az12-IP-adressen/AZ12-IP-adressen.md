## IP adressen

## Key-terms

•	IP adressen
Een IP adres is een logisch adres die aan een netwerkapparaat toegewezen kan worden. De netwerkapparaten kunnen dan vervolgens met dit IP adres elkaar vinden op het netwerk.
Een IPv4 adres heeft 32 bits (8 bytes), en is meestal geschreven in decimalen (bijvoorbeeld: 132.88.142.5) waar iedere blok voor, na, en tussen de punten, 1 byte is. Dit betekent dat één blok tussen punten een maximale waarde kan hebben van 255. 

Het is wijd en zijd bekend in de ICT dat alle IPv4 adressen op zijn. De 8 bytes in een IPv4 adres maakt het mogelijk dat er 4,294,967,296 IPv4 adressen mogelijk zijn. En deze zijn allemaal al verkocht of gereserveerd. Mocht je interesse hebben wie jouw publieke IP adres mocht bezitten, dit is op te zoeken op met een whois-check.

•	IPv4 
Het originele idee dat iedere computer op het internet met ieder een eigen publiek IP(v4) adres aanspreekbaar is, is al lang niet meer zo. Over de jaren heen zijn er een aantal maatregelen genomen om nog langer met IPv4 te kunnen werken. Zo heb je als gebruiker van het internet, achter je modem, maar één publiek IP adres dat je deelt met alle apparaten op het netwerk. Dit is mogelijk vanwege een NAT-tabel in je modem. Een NAT-tabel houd bij welke verbindingen de apparaten in je privé netwerk maken met het publieke internet en zorgt er dan voor dat data als antwoord naar de juiste computers gestuurd worden.

Er zijn 3 IP adres bereiken gereserveerd voor privé netwerken. Iedereen gebruikt één van deze netwerken thuis of op werk. Deze zijn:
•	192.168.0.0 - 192.168.255.255
•	172.16.0.0 - 172.31.255.255
•	10.0.0.0 - 10.255.255.255


    IPv6

Een andere oplossing is IPv6. IPv6 adressen bevatten 128 bits, en is vaak geschreven in hexadecimalen. Het aantal adressen dat mogelijk is met IPv6 zo groot, dat je iedere korrel zand op alle stranden van onze aarde 3 IPv6 adressen kan geven voordat deze op is. Of dat is het verhaal wat vaak verteld wordt bij de voordelen van IPv6 over IPv4.

Wij focussen ons op IPv4. Ondanks dat de transitie naar IPv6 noodzakelijk is, gebruikt AWS en Azure nog steeds voornamelijk IPv4 en is IPv6 een aparte optie die expliciet aangezet moet worden.


•	Public en Private Ips


•	NAT

## Opdracht:
•	Ontdek wat je publieke IP adres is van je laptop en mobiel op wifi

![screenshot IP adressen mijn devices]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/IP%20addresses%20my%20devices.jpg)


•	Ontdek wat je publieke IP adres is op je mobiel via mobiel internet (als mogelijk)

![screenshot VM IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/AZ12%20my%20public%20IP%20address.jpg)


•	Maak een VM in je cloud met een publiek IP. Maak verbinding met deze VM.

![screenshot VM IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/VM%20met%20publieke%20IP.jpg)


![screenshot connective te VM IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/connectie%20te%20VM%20via%20publieke%20IP.jpg)





•	Verwijder het publieke IP adres van je VM. Begrijp wat er gebeurt met je verbinding.

![screenshot ontkoppeling van de publieke IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/ontkoppelen%20van%20de%20publieke%20IP%20van%20de%20subnet.jpg)

![screenshot verwijderen van publieke IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/verwijderen%20van%20de%20publieke%20IP%20adres.jpg)

![screenshot connective failure te VM IP]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ12/VM%20connectie%20failure.jpg)


## Bronnen
https://www.youtube.com/watch?v=OqsXzkXfwRw
https://nl.wikipedia.org/wiki/IP-adres


## Probleem:
geen

## Resultaat
Zie screenshots