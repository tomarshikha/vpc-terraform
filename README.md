Vpc terraform

Our infrastructure is a three-tiered architecture that features the following and more:

A VPC
6 subnets (2 public and 4 private)
A route table associated it with public subnets
A route table associated it with private subnets
Internet Gateway
Public route in table, associated with the Internet Gateway. (This is what allows a public subnet to be accisble from the Internet)
Elastic IPs
Nat Gateway
Security Groups
EC2 Instances for 2 webservers, etc
Launch Templates
Target Groups
Autoscaling Groups# vpc-terraform
