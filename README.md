# SpringbootProject

![AssessmentTopo logy.png](..%2FAssessmentTopology.png)

In order to achieve the topology shown above;

* A SpringBoot project base created using spring initializer, developed on IntelliJ Idea using jdk:17, Maven and packaged as a Jar file. 
* A public Github repository created for the assessment and project components pushed here using basic git commands.
* An Ubuntu 18.04 (Bionic) server used as a Jenkins Server and a Build Server simultaneously in the local environment. 
* Azure Container Registry used to push and store docker images.
* Azure Kubernetes Services used to create Kubernetes Cluster. 
* 'HTTP application routing add-on' used for Azure Kubernetes Service which deploys two components: a Kubernetes ingress controller and an External-DNS controller.

#### On Ubuntu 18.04 Server 

Jenkins Installation completed with the following commands;

`sudo apt-get install openjdk-11-jdk`

`curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null`

`echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null`

`sudo apt-get update`

`sudo apt-get install jenkins`


Jenkins IP and Default Pasword;

http://localhost:8080

`cat /var/lib/jenkins/secrets/initialAdminPassword`
![img.png](img.png)


Docker Installation completed with the following commands;

`sudo apt-get update`

`sudo apt-get install ca-certificates curl gnupg`

`sudo install -m 0755 -d /etc/apt/keyrings`

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`

`sudo chmod a+r /etc/apt/keyrings/docker.gpg`

`echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`

`sudo apt-get update`

`sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`

`sudo usermod -aG docker username`

`sudo chown username:username /var/run/docker.sock -R` //must be applied for 'jenkins' user as well 

Kubectl Installation completed with the following commands;

`curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -`

`sudo touch /etc/apt/sources.list.d/kubernetes.list`

`echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list`

`sudo apt-get update`

`sudo apt-get install -y kubectl`

`sudo reboot`

Jenkins server must be able to execute docker and kubectl commands.

Docker and Kubectl plugins installed from Jenkins UI Manage Plugins section;
![img_1.png](img_1.png)
![img_2.png](img_2.png)

#### Azure Kubernetes Cluster  
![img_3.png](img_3.png)

#### Azure Container Registry
![img_4.png](img_4.png)
ACR attached to kubernetes cluster using;
`az aks update -n KubeCluster -g DevOps --attach-acr AssesmentRegistry`

#### HTTP application routing add-on AKS
![img_5.png](img_5.png)
`az aks show -g DevOps -n KubeCluster \
--query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName -o table`

_46b03f8587a34431b38b.northeurope.aksapp.io_

`az aks get-credentials --resource-group DevOps --name KubeCluster`


![img_6.png](img_6.png)
