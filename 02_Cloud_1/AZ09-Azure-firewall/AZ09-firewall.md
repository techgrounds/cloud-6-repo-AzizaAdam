## Azure Firewall

## Introductie:

Sinds alle bronnen in de cloud altijd online staan, is het belangrijk om deze te beveiligen tegen bedoeld en onbedoeld schadelijk verkeer. Azure Firewalls kunnen VNets beschermen tegen dit verkeer.

Je kan de Firewall in verschillende configuraties gebruiken in een subnet, of in een hub-and-spoke network. Een Firewall heeft altijd een publiek IP adres waar al het inkomend verkeer naartoe gestuurd dient te worden. En een privé IP adres waar al het uitgaande verkeer naartoe moet.

Zoals je eerder geleerd hebt zijn er twee soorten firewalls: stateless, en stateful. Azure Firewall is een stateful firewall. 

## Bestudeer:
Het verschil tussen Basic en Premium Firewall
Het verschil tussen een Firewall en een Firewallbeleid (Firewall Policy)
Dat Azure Firewall veel meer is dan alleen een firewall


## Opdracht:
Zet een webserver aan. Zorg dat de poorten voor zowel SSH als HTTP geopend zijn.
Maak een Azure Firewall in VNET. Zorg ervoor dat je webserver nog steeds bereikbaar is via HTTP, maar dat SSH geblokkeerd wordt.



Azure NSG concnept
![screenshot NSG concept]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09-NSG%20concept.jpg)


New firewall VM
![screenshot New firewall VM]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09%20firewall%20VM.jpg)

Running apache2 through firewall VM:

![screenshot running apache2 by firewall VM]( https://github.com/techgrounds/cloud-6-repo AzizaAdam/blob/main/00_includes/AZ09/AZ09%20apache2%20running%20by%20firewall%20VM.jpg)

![screenshot NGS setting]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09%20firewall%20NSG%20setting.jpg)

![screenshot SSH connection is denied]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09%20SSH%20connection%20is%20denied.jpg)

![screenshot allowing SSH connection again]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09%20SSH%20is%20allowed.jpg)

![screenshot SSH connection is functional]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ09/AZ09%20firewall%20VM%20is%20connected%20via%20SSH.jpg)


## Probleem:
geen 

## Resultaat:
Zie screenshots
