
##Azure Disk Storage  

##Introductie:  

Azure Disk Storage kan gezien worden als een virtual hard drive in de cloud. Een disk kan een OS disk (waar het OS op staat) of een Data Disk (te vergelijken met een externe harde schijf) zijn. Je hebt een keuze tussen Managed Disks en Unmanaged Disks. Unmanaged Disks zijn goedkoper, maar je hebt er wel een Storage Account nodig (en je moet de disk dus zelf managen). Managed Data Disks kunnen gedeeld worden tussen meerdere VMs, maar dat is een relatief nieuwe feature en er zitten wat haken en ogen aan.

Backups van een Managed Disk kan je maken met Incremental Snapshots die alleen de aanpassingen sinds de laatste snapshot opslaan. Voor een Unmanaged Disk kan je alleen een ‘normale’ snapshot maken.

Er zijn 4 typen managed disks. Over het algemeen kan je zeggen dat meer performance zorgt voor hogere kosten:

Detail	Ultra Disk	Premium SSD	Standard SSD	Standard HDD
Disk Type	SSD	SSD	SSD	HDD
Scenario	IO-intensive workloads, such as SAP HANA, top tier databases (for example, SQL Oracle), and other transaction-heavy workloads	Production and performance sensitive workloads	Web servers, lightly used enterprise applications and dev/test	Backup, non-critical, infrequent access
Max disk size	65 536 GiB	32 767 GiB	32 767 GiB	32 767 GiB
Max throughput	2000 MB/s	900 MB/s	750 MB/s	500 MB/s
Max IOPS	160 000	20 000	6000	2000

Een disk kan ge-encrypt worden voor security. Disks kunnen groter worden, maar niet kleiner.
Als je een external device (inclusief een Data Disk) wilt gebruiken op Linux, moet je hem eerst mounten.


## Key-terms:
Azure Managed Disk


## Opdracht:
•	Start 2 Linux VMs. Zorgt dat je voor beide toegang hebt via SSH
•	Maak een Azure Managed Disk aan en koppel deze aan beide VMs tegelijk.
•	Creëer op je eerste machine een bestand en plaats deze op de Shared Disk.
•	Kijk op de tweede machine of je het bestand kan lezen.
•	Maak een snapshot van de schijf en probeer hier een nieuwe Disk mee te maken
•	Mount deze nieuwe Disk en bekijk het bestand. 


Azure shared disc concnept
![screenshot shared disc concept](https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/AZ07%20shareddisc%20concept.jpg)


Attaching shared disc to VM4
![screenshot disc in VM4] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/Az07-attaching%20and%20mounting%20disc%20in%20VM4.jpg)


Attaching shared disc to VM5
![screenshot shared disc to VM5](https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/Az07-attaching%20and%20mounting%20disc%20in%20VM5.jpg)


Adding a shared txt file in the shared disc by VM4:

![screenshot shared text file VM4] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/Az07-making%20shared%20txt%20file%20via%20VM4.jpg)


![screenshot reading the shared text file by VM5] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/Az07-readingthe%20shared%20txt%20file%20via%20VM5.jpg)


![screenshot making snapshot shared disc] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/AZ07-Snapshot%20disc5.jpg)


![screenshot new disc from the snapshot] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/AZ07%20new%20disc%20from%20snapshot.jpg)


![screenshot reading the shared text file from the new disc] (https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ07/Az07-reading%20the%20shared%20txt%20file%20from%20the%20new%20disc.jpg)


## Problemen
Geen 


## Resultaten:
Zie de screenshots

## Bronnen: 
https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types
https://www.youtube.com/watch?v=CSAx5DV4Hts (attaching the disk and mounting it using putyy, nice video)
https://www.youtube.com/watch?v=u8qtTNorRts
https://www.youtube.com/watch?v=LAFjTUudNCY
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal
https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types


