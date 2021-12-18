## Azure Virtual Machines
## Introductie:
De Service waarmee je VMs kan maken in Azure heet (zeer toepasselijk) Azure Virtual Machines. Je kan deze VMs gebruiken voor alles waar je een fysieke server voor zou gebruiken. Omdat ze in een datacenter van Microsoft staan, kan je er alleen verbinding mee maken via het internet. Verbinding met een remote Linux-machine maak je met het Secure Shell (ssh) protocol. Voor een verbinding met Windows machines gebruik je het Remote Desktop Protocol (RDP).

Om een VM aan te maken moet je een image selecteren. Een image is een soort blauwdruk voor je machine. Het bevat onder andere een template voor het OS.

VMs komen in verschillende sizes. Elke size heeft een andere hoeveelheid vCPUs, RAM, Data disks, Max IOPS, Temp storage, Premium disk support en prijs.

Voor de OS disk (de root volume) kan je kiezen uit Premium SSD, Standard SSD en Standard HDD. Je hebt ook de optie om extra Data disks toe te voegen.

Je kan optioneel je VM beveiligen met een NIC network security group. Het wordt aangeraden om network security groups te configureren op subnet niveau (en dus niet op instance niveau) waar mogelijk, maar soms heb je een allow/deny rule nodig op een specifieke instance, dus de optie is er. In elk geval kan je firewalls dus buiten de instance regelen, en hoef je niet binnen de VM nog een extra firewall te configureren.

Met Custom Data kan je een cloud-init script, config file of andere data meegeven tijdens het opstarten van de VM. Hiermee kan je automatisch servers configureren zonder zelf in te loggen.
User data is een nieuwe versie van Custom data. Het grootste verschil is dat user data beschikbaar blijft gedurende de hele levensduur van de VM.


De prijs van een Azure VM hangt af van de size, de image, de regio waar hij in staat, het aantal minuten dat hij aan staat, en het type betaling dat je doet.
•	Pay-as-you-go is de duurste optie, maar ook het meest flexibel.
•	Reserved Instances zijn goedkoper, maar je zit vast aan een reservatie van 1 of 3 jaar.
•	Spot instances zijn over het algemeen het goedkoopst, maar de availability hangt af van de vraag naar VMs op dat moment, dus ze zijn niet altijd betrouwbaar.

## Key terms:

Virtual machine:
 Een VM in Azure biedt je de flexibiliteit van virtualisatie zonder dat je de fysieke hardware hoeft te kopen en te beheren waarop de VM wordt uitgevoerd. U moet de VM echter wel onderhouden door taken uit te voeren, zoals het configureren, patchen en onderhouden van de software die erop wordt uitgevoerd. 


•	Ontwikkeling en tests: Azure-VM’s bieden een snelle en eenvoudige manier om een computer te maken met specifieke configuraties die nodig zijn voor de code van een toepassing en het testen ervan.
•	Toepassingen in de cloud: De vraag naar uw toepassing kan variëren, dus kan het financieel verstandig zijn om deze uit te voeren op een VM in Azure. U betaalt voor extra virtuele machines wanneer u ze nodig hebt en schakelt ze uit wanneer u ze niet meer nodig hebt.
•	Uitgebreid datacenter: Virtuele machines in een virtueel Azure-netwerk kunnen eenvoudig worden verbonden met het netwerk van uw organisatie.


RDP:

Is de remote desk protocol dat helpt om met je Windows Azure VM te verbinden.


SSH:
Is Secure Shell die je nodig hebben om verbinding met je Linux Azure VM.




## Opdracht:
•	Log in bij je Azure Console.
•	Maak een VM met de volgende vereisten:
•	Ubuntu Server 20.04 LTS - Gen1
•	Size: Standard_B1ls
•	Allowed inbound ports:
•	HTTP (80)
•	SSH (22)
•	OS Disk type: Standard SSD
•	Networking: defaults
•	Boot diagnostics zijn niet nodig
•	Custom data: 
	#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2
•	Controleer of je server werkt.
•	Let op! Vergeet na de opdracht niet alles weer weg te gooien. Je kan elk onderdeel individueel verwijderen, of je kan in 1 keer de resource group verwijderen.

## Resultaat:
Connection to Azure VM via putty
![screenshot Azure-VM](https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ06/Conection%20to%20azure%20VM.jpg)

Apache2 installation
![screenshot installation Apache2] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ06/Conection%20to%20azure%20VM.jpg)
h
Apache2 server is running
![screensot apache2 server] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ06/Az06-apache2%20server%20is%20working.jpg)

## Problemen:
Geen


## Conclusies:
We hebben een ubuntu(20.04/ gen 1) VM in Azure gerunt en apache2 server geinstalleert en laten runnen op port 80.

Resources:
https://docs.microsoft.com/nl-nl/azure/virtual-machines/windows/overview
https://jumpcloud.com/blog/rdp-ssh


