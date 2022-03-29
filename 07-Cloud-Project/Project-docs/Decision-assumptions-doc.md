## Decision and assumptions for improvements

## Project v1.0 >> infrastructure as a code (Azure bicep)
Our mission is to help a company with transition to the cloud. The company had its infrastructure analyzed by a previous team. 
The design of the project is depicted below:

![original-projectv1.0-design]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/Project-designs/Original%20project%20design.jpg) 

We are going to use Infrastructure as Code to bring this design to the cloud using Bicep from Azure.

## The following requirements are indicated as necessary:

A list describing deliverables:
-   All VM disks must be encrypted.
-   The webserver and admin needs to be backed up daily. The backups need to be kept
    for 7 days.
-   The webserver needs to be installed in automated manner.
-   Same bootstrap script used for deployment of webserver must be uploaded to an 
    encrypted storage account.
-   The admin/management server needs to be available through a public IP.
-   
    (office/home).
-   The following IP ranges will be used: 10.10.10.0/24 & 10.20.20.0/24
-   All subnets must be protected on a subnet level by NSGs.
-   SSH or RDP connections with the webserver can only be achieved from the admin server.
-   Webserver should be a Linux system, while the admin server should be a Windows server.
-   SSH connections to the webserver from the admin server must be accomplished through
    private ips (by way of the Vnet peering).

 
## Potential improvements to architecture
•	Adding a firewall to ensure more security and resiliency to the resources.
•	Applying autoscaling to have better response to different workload (elastic performance).
•	Applying content delivery service to ensure better caching of the services to end-users.
Those changes were discussed with the product owner and for version 1.0 we agreed to keep the IaC as simple as it can to have a minimum viable product then some changes acan be introduced in version 1.1.


