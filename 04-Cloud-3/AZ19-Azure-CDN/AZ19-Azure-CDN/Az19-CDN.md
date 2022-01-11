## Content Delivery Network (CDN)
	
A content delivery network (CDN) is a distributed network of servers that can efficiently deliver web content to users. CDNs' store cached content on edge servers in point-of-presence (POP) locations that are close to end users, to minimize latency.

The benefits of using Azure CDN to deliver web site assets include:
•	Better performance and improved user experience for end users, especially when using applications in which multiple round-trips are required to load content.
•	Large scaling to better handle instantaneous high loads, such as the start of a product launch event.
•	Distribution of user requests and serving of content directly from edge servers so that less traffic is sent to the origin serve

![Azure-CDN]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ20/Azure%20public%20and%20private%20DNS.jpg)  

1.	A user (Alice) requests a file (also called an asset) by using a URL with a special domain name, such as <endpoint name>.azureedge.net. This name can be an endpoint hostname or a custom domain. The DNS routes the request to the best performing POP location, which is usually the POP that is geographically closest to the user.
2.	If no edge servers in the POP have the file in their cache, the POP requests the file from the origin server. The origin server can be an Azure Web App, Azure Cloud Service, Azure Storage account, or any publicly accessible web server.
3.	The origin server returns the file to an edge server in the POP.
4.	An edge server in the POP caches the file and returns the file to the original requestor (Alice). The file remains cached on the edge server in the POP until the time-to-live (TTL) specified by its HTTP headers expires. If the origin server didn't specify a TTL, the default TTL is seven days.
5.	Additional users can then request the same file by using the same URL that Alice used, and can also be directed to the same POP.
6.	If the TTL for the file hasn't expired, the POP edge server returns the file directly from the cache. This process results in a faster, more responsive user experience.



## Limitations
Each Azure subscription has default limits for the following resources:
•	The number of CDN profiles that can be created.
•	The number of endpoints that can be created in a CDN profile.
•	The number of custom domains that can be mapped to an endpoint.


Azure Content Delivery Network (CDN) includes four products:
•	Azure CDN Standard from Microsoft
•	Azure CDN Standard from Akamai
•	Azure CDN Standard from Verizon
•	Azure CDN Premium from Verizon

## Key-terms
					
•	TTL: 
Time -to- live, The file remains cached on the edge server in the POP until the time-to-live (TTL) specified by its HTTP headers expires. If the origin server didn't specify a TTL, the default TTL is seven days. If you publish a website through Azure CDN, the files on that site are cached until their TTL expires. The Cache-Control header contained in the HTTP response from origin server determines the TTL duration.
Default TTL values are as follows:
•	Generalized web delivery optimizations: seven days
•	Large file optimizations: one day
•	Media streaming optimizations: one year


•   Geo-filtering
Geo-filtering enables you to allow or block content in specific countries, based on the country code. In the Azure CDN Standard for Microsoft Tier, you can only allow or block the entire site. With the Verizon and Akamai tiers, you can also set up restrictions on directory paths.

			


	
## Bronnen	

https://docs.microsoft.com/en-us/learn/modules/develop-for-storage-cdns/
https://nl.wikipedia.org/wiki/Content_delivery_network
https://docs.microsoft.com/en-us/learn/modules/develop-for-storage-cdns/1-introduction
https://www.youtube.com/watch?v=mpRngA7HYH8


