## Azure DNS 
	

The Domain Name System (DNS) is the hierarchical and decentralized naming system used to identify computers, services, and other resources reachable through the Internet or other Internet Protocol (IP) networks. The resource records contained in the DNS associate domain names with other forms of information. These are most commonly used to map human-friendly domain names to the numerical IP addresses computers need to locate services and devices using the underlying network protocols.

Azure DNS is a cloud service that allows you to host and manage domain name system (DNS) domains, also known as DNS zones. Azure DNS allows your organization to host and manage public and private DNS records. 

Azure DNS allows you to manage DNS zone data using the Azure portal, Azure PowerShell, the Azure CLI, and Rest APIs. Instead of having to manage DNS zone data through a third-party DNS provider or hosting and managing a DNS Server service yourself on a physical server or virtual machine.

DNS zones in Azure DNS are hosted across Azure's global network of DNS name servers. These servers use Anycast networking so that queries for DNS zone data will be answered by the DNS server closest to the querying client.

DNS records can relate a Fully Qualified Domain Name (FQDN) associated with the zone to an IP address or another DNS record. For example, www.tailwindtraders.com (a host record) mapping to a specific IP address (40.71.177.34).

Azure DNS supports all common DNS record types including A, AAAA, CNAME, MX, PTR, SOA, SRV, and TXT records. Azure DNS supports records that map to both IPv4 and IPv6 addresses.



## Key-terms

•	Azure DNS public zone
•	
Azure DNS public zone host domain name zone data for records that you intend to be resolved by any host on the internet. Azure DNS public zones support all common DNS record types including A, AAAA, CNAME, MX, PTR, SOA, SRV, and TXT records
•	
•	Azure DNS private zone
•	
Many organizations use internal DNS names that are separate from public DNS names for hosts on their internal on-premises networks. Azure Private DNS zones allow you to replicate this functionality by configuring a private DNS zone namespace that can be used to map FQDNs with private Azure resources.	Azure DNS private zones support all common DNS record types.
A diagram shows the integration of the Azure DNS public zone tailwindtraders.com with the Azure DNS private zone tailwindtraders.com in split-horizon configuration.

![Azure-DNS]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ20/Azure%20public%20and%20private%20DNS.jpg)

## Excersice
Set Azure DNS zone to host your website DNS and set new record with your website IP.

![Azure-DNS-zone-zizola.net]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ20/Azure%20DNS%20for%20zizola.net.jpg)


•	FQDN
Short-cut for fully qualified domain name such as www.zizola.net		
				
## Bronnen
	
https://en.wikipedia.org/wiki/Domain_Name_System
https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-dns/
https://www.youtube.com/watch?v=SpFmpIvtFbM



