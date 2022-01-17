## Container
A container is a loosely isolated environment that allows us to build and run software packages. These software packages include the code and all dependencies to run applications quickly and reliably on any computing environment. We call these packages container images.
The container image becomes the unit we use to distribute our applications. A container image is a portable package that contains software. It's this image that, when run, becomes our container. The container is the in-memory instance of an image.
## Docker benefits
When we use Docker, we immediately get access to the benefits containerization offer.
1.	Efficient use of hardware
Containers run without using a virtual machine (VM). As we saw, the container relies on the host kernel for functions such as file system, network management, process scheduling, and memory management.

![Docker-server-vs-own-server]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  



2.	Container isolation
Docker containers provide security features to run multiple containers simultaneously on the same host without affecting each other.
Image 
3.	Application portability
Containers run almost everywhere, desktops, physical servers, VMs, and in the cloud. This runtime compatibility makes it easy to move containerized applications between different environments.
4.	Application delivery
With Docker, the container becomes the unit we use to distribute applications. This concept ensures that we have a standardized container format used by both our developer and operation teams. Our developers can focus on developing software and the operations team on the deployment and management of software.
5.	Management of hosting environments
Our team can also manage which applications to install, update, and remove without affecting other containers. Each container is isolated and has its resource limits assigned separately from other containers. For example, you can deploy Docker containers to Azure Container Instances, Azure App Service, and Azure Kubernetes Services. Each of these options provides you with different features and capabilities.

6.	Cloud deployments
Docker containers are the default container architecture used in the Azure containerization services and are supported on many other cloud platforms.
## Precautions using Docker containers:
Containers provide a level of isolation. However, containers share a single host OS kernel, which can be a single point of attack.
We also need to take into account configure aspects such as storage and networks to make sure that we consider all security aspects. For example, all containers will use the bridge network by default and can access each other via IP address.
Managing the applications and containers are more complicated than traditional VM deployments. Logging features exist that tell us about the state of the running containers. However, more detailed information about services inside the container is harder to monitor.

## Key-terms
Host OS
The host OS is the OS on which the Docker engine runs. Docker containers running on Linux share the host OS kernel and don't require a container OS as long as the binary can access the OS kernel directly. However, Windows containers need a container OS. 
The container depends on the OS kernel to manage services such as the file system, network management, process scheduling, and memory management.
Docker container:
The Docker platform consists of several components that we use to build, run, and manage our containerized applications.
Image (docker)
![Docker-architecture]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  


![Docker-vs-own-server-security]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  

The Docker client
The Docker client is a command-line application named docker that provides us with a command line interface (CLI) to interact with a Docker server. The docker command uses the Docker REST API to send instructions to either a local or remote server and functions as the primary interface we use to manage our containers.
The Docker server
The Docker server is a daemon named dockerd. The dockerd daemon responds to requests from the client via the Docker REST API and can interact with other daemons. The Docker server is also responsible for tracking the lifecycle of our containers.
Docker objects
There are several objects that you'll create and configure to support your container deployments. These include networks, storage volumes, plugins, and other service objects.
Docker Hub
Docker Hub is a Software as a Service (SaaS) Docker container registry. Docker registries are repositories that we use to store and distribute the container images we create. Docker Hub is the default public registry Docker uses for image management.
Dockerfile
A Dockerfile is a text file that contains the instructions we use to build and run a Docker image. 

Stackable Unification File System (UnionFs)
Unionfs is used to create Docker images. Unionfs is a filesystem that allows you to stack several directories, called branches, in such a way that it appears as if the content is merged. However, the content is physically kept separate. Unionfs allows you to add and remove branches as you build out your file system.
## image 
![UnionFs]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  



or example, assume we're building an image for our web application from earlier. We'll layer the Ubuntu distribution as a base image on top of the boot file system. Next we'll install Nginx and our web app. We're effectively layering Nginx and the web app on top of the original Ubuntu image.
A final writeable layer is created once the container is run from the image. This layer however, does not persist when the container is destroyed.

## Azure container instance
Azure Container Instances (ACI) is a great solution for any scenario that can operate in isolated containers, including simple applications, task automation, and build jobs. Here are some of the benefits:
•	Fast startup: ACI can start containers in Azure in seconds, without the need to provision and manage VMs
•	Container access: ACI enables exposing your container groups directly to the internet with an IP address and a fully qualified domain name (FQDN)
•	Hypervisor-level security: Isolate your application as completely as it would be in a VM
•	Customer data: The ACI service stores the minimum customer data required to ensure your container groups are running as expected
•	Custom sizes: ACI provides optimum utilization by allowing exact specifications of CPU cores and memory
•	Persistent storage: Mount Azure Files shares directly to a container to retrieve and persist state
•	Linux and Windows: Schedule both Windows and Linux containers using the same API.
Multi-container groups currently support only Linux containers. For Windows containers, Azure Container Instances only supports deployment of a single instance.

•	You can only mount Azure Files shares to Linux containers.
•	Azure file share volume mount requires the Linux container run as root.
•	Azure File share volume mounts are limited to CIFS support.
## Azure Kubernetes service
It is a tool to manage container-based apps (managed service)Pods:. Ideal to manage and orchestrate micro-services based-apps, for both stateless and stateful applications.

## Pods
A tool to run instance of the app, normally each app is mapped to a single container.
## Deployment
Deploying one or multiple Pods. If Kubernetes scheduler finds some issues in the health of pods or nodes then new pods are created.



## Hands-On ACI

![My-ACI]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  


![Connection-to-ACI]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ23/Azure%20function%20APP-HTTP-trigger.jpg)  


## Hands-On AKS
![My-AKS]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ24/My%20AKS.jpg)  


![Connection-to-AKS]( https://github.com/techgrounds/cloud-6-repo-AzizaAdam/blob/main/00_includes/AZ24/connection%20to%20AKS.jpg)  


## Bronnen
https://docs.microsoft.com/en-us/learn/modules/intro-to-docker-containers/3-how-docker-images-work
https://www.whizlabs.com/learn/course/microsoft-azure-certification-az-900/256/video



