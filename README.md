- [VPC Launch](#vpc-launch)
  - [VPC Components](#vpc-components)
  - [Terraform Modules](#terraform-modules)

  <hr />

# VPC Launch

> This repo insted to had a basic network infrastructure. The basical idea it´s have two Subnets, one public and other privated with an Internet gateway (_igw_) connected to the public one. And the routing table that permit 0.0.0.0/0 traffic between the public subnet and the igw.

An overview of what will be created on AWS onece execute the terraform manifiest.

![vpc_map.png](./img/vpc_map.png)

## VPC Components

1. VPC (_10.0.0.0/16_)
2. Public Subnet (_10.0.1.0/24_)
3. Private Subnet (_10.0.2.0/24_)
4. Public Routing Table (_Public Subnet <-> 0.0.0.0/0_)
5. Security group (_Allow traffic to '80','443','22','3389'_)

### VPC

> This module will help you to create a default VPC, with a default addressing (10.0.0.0/16) no bigger configurations should have to do here only you can change the Region and the addres that you want from here

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf <-- HERE you can change the VPC addressing and the Region.
│ 
```

### Public Subnet

> This subnet at the moment to be created is just a privated subnet with the name "public", only will be public if is associated to an Internet Gateway for example.
> The creation and modification over the public subnete, can be made on the "variables.tf" root file, you can change the IP, Name and Availability Zone.

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf <-- HERE you can change the Public Subnets configuration.
│ 
```


## Terraform Modules

```
\
│   main.tf
│   outputs.tf
│   README.md
│   variables.tf
│   
├───img
│       vpc_map.png
│
└───modules
    ├───igw
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───routing_table
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───sg
    │       main.tf
    │       outputs.tf
    │       variables.tf
    │
    ├───subnets
    │       main.tf
    │       output.tf
    │       variables.tf
    │
    └───vpc
            main.tf
            output.tf
            variables.tf
```
