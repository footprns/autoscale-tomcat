# autoscale-tomcat

There are some application using tomcat in few virtual servers behind the loadbalancer.

## Design
1. Using AWS free tier 
2. Using Terraform to build the infrastructure
3. Using SaltStack to deploy application

Assumtion:
1. It is an internal application inside VPC
2. I used jumphost server to control infrastructure

Action:
1. Create jumphost

![Diagram](/images/diagram.png)
