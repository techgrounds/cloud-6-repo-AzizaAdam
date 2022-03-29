## Project v1.1 (Cloud6.Sentia1)
## Introduction:
In the past weeks you have been working on the first version of your application. You also delivered this last Friday. You have learned how to deal with the CDK or Bicep. You have built an application. You have thought about how to inform the customer about the use of your application.

You may not have finished everything yet and that's okay. In this case, you would indicate to your supervisor that you need more time and discuss this with the customer. Since this is still a simulation, this is not necessary. The focus is on learning the concepts you will need to contribute to your future team. And if you keep learning, no time is wasted.

Regardless of the status of your v1.0 application, this is not the end of the project. Customers can often change their mind and use more 'features'. Or the development of these extra features has been agreed in advance.

Part of the simulation is that the architect and product owner who created your user stories for this are on vacation. So you have to do a little more yourself for v1.1 of the application.
Assignment:
The customer is satisfied with the delivery of your application. This is just not the end. The customer would like to make more use of the possibilities of the cloud. In addition, the customer has comments about the security of the application.

While the consultant is hammering out the details with the client. Have the architect and product owner announced that they are going on vacation and will not be present to support your team with the new version of the application. You will therefore document the changes yourself and create user stories yourself.

After a few days, the consultant returns with a new list of requirements while your team is missing a few members.

## New Requirements:
The customer would like to use more possibilities of the cloud. In addition, the customer has also indicated that it would like to comply with more security best practices that have not yet been implemented in the current version. Together with the consultant, the client has drawn up the following:
• The web server should no longer be accessible “naked” on the internet. The customer prefers to see a load balancer intervene. The server will no longer have to have a public IP address.
• Should a user connect to the load balancer via HTTP, this connection should be automatically upgraded to HTTPS.
• The connection must be secured with at least TLS 1.2 or higher.
• The web server must undergo a 'health check' on a regular basis.
• Should the web server fail this health check, the server should be automatically restored.
• Should the web server be under continuous load, a temporary additional server should be started up. The customer believes that no more than 3 servers in total are ever needed given the user numbers in the past.

## Deliverables:
The following objects must be provided for v1.1 of your application:
• Updated versions of the following documents:
o Architectural drawing
o The substantiation of the new services used in the design document
o An MVP of v1.1


## Ongoing:
o Your daily log with your findings
o The interim presentations
o The final presentation

e



https://docs.microsoft.com/en-us/azure/application-gateway/redirect-http-to-https-portal
https://stackoverflow.com/questions/15084511/how-to-detect-https-redirection-on-azure-websites
https://docs.microsoft.com/en-us/azure/application-gateway/redirect-http-to-https-cli

