# Introduction

> This repository contains the solution for a technical challenge involving the deployment of AWS infrastructure using Terraform. The challenge simulates a real-world scenario where modular, secure, and scalable infrastructure must be provisioned and maintained.
>
> The purpose of this project is to demonstrate infrastructure-as-code (IaC) skills, cloud architecture design, and DevOps practices using Terraform, AWS, and optionally GitHub Actions.

<hr />

# Challenge Requirements

> The challenge consists of deploying the following components:

| Component | Details |
| :- | :- |
| VPC | CIDR block `10.1.0.0/16` |
| Subnet 1 | `10.1.0.0/24` (Public, AZ1) |
| Subnet 2 | `10.1.1.0/24` (Public, AZ2) |
| Subnet 3 | `10.1.2.0/24` (Private, AZ1) |
| Subnet 4 | `10.1.3.0/24` (Private, AZ2) |
| EC2 Instance | In Subnet 2, t2.micro, RedHat Linux, 20 GB |
| Auto Scaling Group | In Subnets 3 and 4, RedHat Linux, Apache via user-data, t2.micro |
| | IAM role to read from S3 "images", Min: 2 / Max: 6 |
| Application Load Balancer | Listens on port 80, forwards to ASG on port 443 |
| S3 Bucket: `images` | Folders: `archive/`, `memes/` (memes → Glacier after 90 days) |
| S3 Bucket: `logs` | Folders: `active/`, `inactive/` (inactive → delete after 90 days) |
| IAM Roles | Allow EC2 and ASG to write logs to the `logs` bucket |

<table>
<tr>
<td> Note</td>
<td> The complete and detailed PDF version of the challenge requirements is available in the expandable section below. This includes the original assignment document provided by the company, presented as images hosted on Google Drive for easy reference.</td>
</tr>
</table>

<details>
<summary>AWS Technical Challenge details.</summary>

<br />

<img src="https://drive.google.com/uc?id=135la1d52GCZPFHAAi6kUSUcv_y18Plkg">
<img src="https://drive.google.com/uc?id=1VcUamkUyo6oKIpmAcsWDQFLj_8o9FULr">
<img src="https://drive.google.com/uc?id=1mYzOGHjMEg198WMzi5i_j8YMnNDdYGk1">
<img src="https://drive.google.com/uc?id=1y53JtVmNnImnI0PVzfGRlM7wDYuJSxdD">

</details>

<hr />

# Solution overview

> This project is structured as an infrastructure-as-code deployment using Terraform. Two modes of execution are supported:
>
> 1. Local Execution: Developers can apply infrastructure changes from their local machines using the Terraform CLI.
> 2. Remote Execution (Improvement Plan): Infrastructure is deployed automatically via GitHub Actions on PR merges.

## Pre-requisites

> Please find bellow the pre-requisites

<details>
<summary>GitHub account</summary>

> The GitHub account is easly to be created, just go to [www.github.com](https://www.github.com).
> If you need more information about the GitHub account creation process, please refer to: [Creating an account on GitHub](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github)

</details>

<details>
<summary>AWS account</summary>

> The GitHub account is easly to be created, just go to: [AWS Free tier](https://aws.amazon.com/es/free/?gclid=Cj0KCQjw4qHEBhCDARIsALYKFNPnE6_Knezg_C6o9NplWfM2DgjD5C-jHADXOWhsRq3reozrkAwuCTIaAl8eEALw_wcB&trk=8185e5da-db92-479f-91f4-d73ac3fcd9e5&sc_channel=ps&ef_id=Cj0KCQjw4qHEBhCDARIsALYKFNPnE6_Knezg_C6o9NplWfM2DgjD5C-jHADXOWhsRq3reozrkAwuCTIaAl8eEALw_wcB%3AG%3As&s_kwcid=AL%214422%213%21648113981729%21e%21%21g%21%21create+aws+account%2119666585841%21146843812798&gad_campaignid=19666585841&gbraid=0AAAAADjHtp-RUpxg6Q1rcN5DSaZO3cX3u&ams%23interactive-card-vertical%23pattern-data-339318104.filter=%257B%2522filters%2522%253A%255B%255D%257D)

</details>

<details>
<summary>Terraform</summary>

> For download Terraform please follow this link: [Install Terraform](https://developer.hashicorp.com/terraform/install#windows)
> If you wana know more about the installation process you can go to the following link: [A Beginner’s Guide to Installing Terraform on Windows](https://medium.com/@morsi.masmoudi/a-beginners-guide-to-installing-terraform-on-windows-9321e566893d)

</details>

<details>
<summary>Visual Studio Code</summary>

> For this challenge I been choised to use vsCode, you can download directly from:
> If you wana know more about the installation process you can go to the following link: [Visual Studio Code on Windows](https://code.visualstudio.com/docs/setup/windows)

</details>

## Best practices

> Knowing that this challenge is used to determine the skills of a cloud engineer in a work environment, it is recommended, but not mandatory, to follow certain design and security guidelines. Below you can find the necessary configurations on the AWS, GitHub, and Terraform platforms to prepare the environment for running the proof of concept..

<details>
<summary>GitHub best practises.</summary>

1. Create a private repository: The purpose of this is to make it public once you've consolidated the solution.
2. Create more than one branch: In professional environments, and as best practice, it's not common to work and test in the same environment because it's unsafe and can cause service disruptions. The code produced must be reviewed and approved before merging into the main branch. Therefore, when developing this activity, it was considered to develop it in a branch called DEV, and once the development is complete through a pull request, merge it into main.
3. Create secrets: Create secrets in the GitHub project to store AWS credentials for remote execution.

</details>

<details>
<summary>AWS best practises.</summary>

1. Don't use the root user, create an admin account.
2. Define the authentication method for GitHub.
3. Create a role for Terraform.
4. Define policies for the Terraform role, only giving it privileges for what it should do.
5. Integrate between AWS and GitHub.
6. Install AWS CLI on Windows 11 to develop locally first.
7. Install Terraform on Windows 11 to test the code and ensure proper resource provisioning in AWS.

</details>

<hr />

## Deployment instructions

## Design decisions and assumptions

## References to resources used

| Reference | Link | Description |
| - | - | :- |
| Terraform  | [A Beginner’s Guide to Installing Terraform on Windows](<https://medium.com/@morsi.masmoudi/a-beginners-guide-to-installing-terraform-on-windows-9321e566893d>) | 
| Markdown | [Embedding images in google drive to markdown](https://www.intodeeplearning.com/embedding-images-in-google-drive-to-markdown/) |

## Assumptions made

## Improvement plan with priorities

## Analysis of operational gaps

## Solutions Diagram

| **Clarification**: The following SD is properly formatted and styled diagram against AWS diagram standards. |
|-|

**Content**

o All deployed components identified
o Connectivity/dataflow’s identified

## Terraform configurations

Please find below Terraform solution diagram content




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
