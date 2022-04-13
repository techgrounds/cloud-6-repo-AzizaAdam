
## Azure Global Infrastructure

## Introductie:
Alles in de cloud, van servers tot networking, is virtualized. Als klant van een cloud provider hoef je je geen zorgen te maken over de onderliggende fysieke infrastructuur. De fysieke locatie van je applicatie of data kan echter wel belangrijk zijn.

De global infrastructure van Azure bestaat uit de volgende componenten:
•   Regions
•   Availability Zones
•   Region Pairs

Je hebt zelf controle over welke regio je gebruikt, maar niet elke service is beschikbaar in elke regio. Sommige services zijn ook niet gebonden aan een specifieke regio. Denk hierbij bijvoorbeeld aan Azure Subscriptions.
Benodigdheden:
Goed info search

 
## Key-terms:

Azure Region
Azure-regio's: zijn groepen datacenters die zijn verbonden met netwerken en vertegenwoordigen de infrastructuur van de cloud. Azure heeft meer dan 50 regio's die verschillende gebieden in de wereld bestrijken, de VS, de EU, Afrika, Azië enz. Tussen de datacenter of a regie is low-latency network van <2 millisec.). Er zijn ook speciale regio's, overheidsregio's (Amerikaanse overheid) en partnerregio's (China)

Azure Availability Zone
Availability zones: Zijn fysiek geschiedend locaties binnen elke Azure-regio die tolerant zijn voor lokale fouten. Storingen kunnen variëren van software- en hardwarestoringen tot gebeurtenissen zoals aardbevingen, overstromingen en branden. Tolerantie voor fouten wordt bereikt vanwege redundantie en logische isolatie van Azure-services. Om de tolerantie te garanderen, zijn er minimaal drie afzonderlijke beschikbaarheidszones aanwezig in alle regio's waarvoor beschikbaarheidszones zijn ingeschakeld.

Azure-beschikbaarheidszones zijn verbonden door een krachtig netwerk met een retourlatentie van minder dan 2 ms. Ze helpen uw gegevens gesynchroniseerd en toegankelijk te houden wanneer er iets misgaat. Elke zone bestaat uit een of meer datacenters die zijn uitgerust met onafhankelijke stroom-, koeling- en netwerkinfrastructuur. Beschikbaarheidszones zijn zo ontworpen dat als één zone wordt getroffen, regionale services, capaciteit en hoge beschikbaarheid worden ondersteund door de overige twee zones.


Azure Region Pair
Regio's zijn gekoppeld voor replicatie tussen regio's op basis van nabijheid en andere factoren.

Advantages of region pairing:
Region recovery sequence: 
Als zich een geografische storing voordoet, krijgt herstel van één regio prioriteit uit elke ingeschakelde set regio's. Toepassingen die worden geïmplementeerd in ingeschakelde regiosets, hebben gegarandeerd een van de regio's met prioriteit voor herstel. Als een toepassing in verschillende regio's wordt geïmplementeerd, waarvan geen enkele is ingeschakeld voor interregionale replicatie, kan het herstel worden uitgesteld.
Sequential updates: 
Geplande Azure-systeemupdates voor uw ingeschakelde regio's worden chronologisch gespreid om downtime, de impact van bugs en eventuele logische fouten in het zeldzame geval van een foutieve update te minimaliseren.
Fysical isolation: 
Azure streeft naar een minimale afstand van 300 mijl (483 kilometer) tussen datacenters in ingeschakelde regio's, hoewel dit niet in alle geografische gebieden mogelijk is. Scheiding van datacenters verkleint de kans dat natuurrampen, stroomstoringen of fysieke netwerkstoringen meerdere regio's kunnen treffen. 
Data residency: 
Regio's bevinden zich in dezelfde geografie als hun ingeschakelde set om te voldoen aan de vereisten voor gegevensresidentie voor belasting- en wetshandhavingsjurisdicties.

## Opdracht:
Waarom zou je een regio boven een andere verkiezen?
Beschikbare services: 
Services die in elke regio worden geïmplementeerd, verschillen op basis van verschillende factoren. Selecteer een regio voor uw werkbelasting die de gewenste service bevat. 

 Capaciteit:
Elke regio heeft een maximale capaciteit. Dit kan van invloed zijn op welke typen abonnementen welke typen services kunnen worden geïmplementeerd en onder welke omstandigheden. Als u een grootschalige datacentermigratie naar Azure plant, kunt u het beste overleggen met uw lokale Azure-veldteam of accountmanager om te bevestigen dat u op de benodigde schaal kunt implementeren.

Beperkingen: 
Er worden bepaalde beperkingen gesteld aan de implementatie van services in bepaalde regio's. Sommige regio's zijn bijvoorbeeld alleen beschikbaar als back-up- of failoverdoel. Andere beperkingen die belangrijk zijn om op te merken, zijn vereisten op het gebied van gegevenssoevereiniteit.
Soevereiniteit: 
Bepaalde regio's zijn toegewijd aan specifieke soevereine entiteiten. Hoewel alle regio's Azure-regio's zijn, zijn deze soevereine regio's volledig geïsoleerd van de rest van Azure. Ze worden niet noodzakelijkerwijs beheerd door Microsoft en zijn mogelijk beperkt tot bepaalde typen klanten. Deze soevereine regio's zijn: Azure China 21Vianet, Azure Duitsland, Azure Amerikaanse overheid. 
Als u gaat kiezen eerst speed test uitvoeren om de snelste regio te bepalen, dan ook ga checken welke producten zijn beschikbaar voor u dan kan u een beslising maken welke regio te gaan keizen.


## Bronnen:
1.  https://www.youtube.com/watch?v=C-nNw1mGwzE
2.  https://docs.microsoft.com/en-us/azure/availability-zones/az-overview
3.  https://docs.microsoft.com/en-us/azure/availability-zones/cross-region-replication-azure
4.  https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions
5.  https://docs.microsoft.com/nl-nl/learn/modules/intro-to-azure-fundamentals/introduction



