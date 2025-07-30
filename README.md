# Introduction

> This repository contains the solution for a technical challenge involving the deployment of AWS infrastructure using Terraform. The challenge simulates a real-world scenario where modular, secure, and scalable infrastructure must be provisioned and maintained.
>
> The purpose of this project is to demonstrate infrastructure-as-code (IaC) skills, cloud architecture design, and DevOps practices using Terraform, AWS, and optionally GitHub Actions.

<hr />

# Challenge Requirements

> The challenge consists of deploying the following components:

<details>
<summary>Components list</summary>

| <div align="center">Component</div> | <div align="center">Details</div> |
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

</details>

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

| <div align="center">Execution Mode</div> | <div align="center">Description</div> |
| :- | :- |
| Local Execution | _Developers can apply infrastructure changes from their local machines using the Terraform CLI._ |
| Remote Execution | _Infrastructure is deployed automatically via GitHub Actions on PR merges._ |

## Infrastructure Diagram

```mermaid
graph TB
    Internet((Internet)) --> IGW[Internet Gateway]
    IGW --> VPC[VPC 10.1.0.0/16]

    VPC --> Pub1[Public Subnet 1]
    VPC --> Pub2[Public Subnet 2]
    VPC --> Priv1[Private Subnet 3]
    VPC --> Priv2[Private Subnet 4]

    Pub1 --> ALB[Application Load Balancer]
    Pub2 --> ALB

    Pub2 --> EC2[EC2 Instance - t2.micro]

    ALB --> ASG[Auto Scaling Group]

    ASG --> Priv1
    ASG --> Priv2

    ASG --> Images[S3 Bucket: images]
    EC2 --> Logs[S3 Bucket: logs]

    subgraph S3_Buckets
        Images
        Logs
    end
```

## Pre-requisites

> Before deploying the infrastructure, ensure your local development environment has the necessary tools and accounts configured. Each of the following prerequisites includes links to the documentation or installers to facilitate setup.

<details>
<summary>GitHub account</summary>

> To complete this challenge, you will need a GitHub account to store your code and version history.
>
> You can create an account by visiting [www.github.com](https://www.github.com).
> For detailed instructions on how to create a GitHub account, refer to the official documentation:  
> [Creating an account on GitHub](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github)

</details>

<details>
<summary>AWS account</summary>

> To provision cloud infrastructure, you will need an AWS account with access to the Free Tier.
>
> You can create an AWS account by visiting the official registration page:  
> [AWS Free Tier Sign-Up](https://aws.amazon.com/es/free/)
>
> The Free Tier offers sufficient resources to complete this challenge without incurring costs, as long as services are used within the defined limits.

</details>

<details>
<summary>AWS CLI</summary>

> The AWS Command Line Interface (CLI) allows you to interact with AWS services directly from your terminal, which is essential for authentication, configuration, and operational tasks during local development.
>
> Download and install the AWS CLI by following the instructions here:  
> [Installing the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
>
> For a quick setup and basic usage guide, refer to:  
> [AWS CLI Getting Started Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

</details>


<details>
<summary>Terraform</summary>

> Terraform is the main tool used to provision infrastructure in this challenge.  
>
> You can download the latest version for your operating system here:  
> [Terraform Installation Guide](https://developer.hashicorp.com/terraform/install#windows)
>
> If you are new to Terraform, this beginner-friendly tutorial may help you with the setup and usage:  
> [A Beginner’s Guide to Installing Terraform on Windows](https://medium.com/@morsi.masmoudi/a-beginners-guide-to-installing-terraform-on-windows-9321e566893d)

</details>

<details>
<summary>Visual Studio Code</summary>

> Visual Studio Code (_VS Code_) is a recommended text editor for working with Terraform projects.  
>
> You can download the installer from the official website:  
> [Download Visual Studio Code](https://code.visualstudio.com/)
>
> For setup instructions specific to Windows, refer to:  
> [Visual Studio Code on Windows](https://code.visualstudio.com/docs/setup/windows)

</details>

## Best Practices

To align with industry standards and demonstrate a real-world approach to cloud infrastructure design, it's recommended to follow a set of best practices across the platforms used in this challenge. These practices improve **security**, **automation**, and **team collaboration**.

<details>
<summary>AWS</summary>

<br />

| <div align="center">Practice</div> | <div align="center">Description</div> |
| :- | :- |
| Use IAM roles for automation | Create a dedicated role for Terraform with least-privilege permissions. This improves security and aligns with the principle of least privilege. |
| Integrate AWS CLI locally | Use `aws configure` to authenticate and test infrastructure outside the web console. |


</details>

<details>
<summary>GitHub</summary>

<br />

| <div align="center">Practice</div> | <div align="center">Description</div> |
| :- | :- |
| Work with feature branches | Use branches like `dev`, `infra`, or `feature/*` to isolate changes, then merge to `main` via Pull Requests. |
| Use GitHub Secrets| Store AWS credentials and other sensitive variables in GitHub Actions Secrets. |
| Enable branch protection | Protect the `main` branch from force pushes and require reviews before merging. |

</details>

<details>
<summary>Terraform</summary>

<br />

| Practice | Description |
| :- | :- |
| Use a remote backend | Store the Terraform state in S3. |
| Write modular code | Organize resources in reusable modules for scalability. |
| Run format and validation | Use `terraform fmt` and `terraform validate` on every commit. |
| Use variables and outputs | Externalize configuration and expose useful outputs. |
| Pin provider versions |  Lock your provider and Terraform versions in `required_providers`. |

</details>

<hr />

## Architecture Design

> This section outlines the structural and strategic choices made in designing the cloud infrastructure. The goal was to build a scalable, modular, and secure environment that simulates real-world enterprise use cases.

<details>
<summary> Design decisions</summary>

<br />

> - Modular structure: all core components (_VPC, subnets, IGW, SGs, etc._) are implemented via reusable modules.
> - CIDR blocks are parameterized to support easy scaling.
> - High availability is achieved using subnets across two AZs.
> - ALB to ASG communication uses HTTPS (_443_) for simulated security context

</details>


<details>
<summary> Assumptions</summary>

<br />

> - AWS region used is us-east-1.
> - EC2 AMI for Red Hat Linux is available in the selected region.
> - Buckets images and logs are created and managed via Terraform.
> - Apache installed via user-data shell script.

</details>

<hr />

## Deployment Instructions

> Before running the Terraform configuration, it's important to prepare your local environment by setting up AWS credentials via the AWS CLI. This allows Terraform to authenticate with AWS and provision infrastructure.
>
> If you haven't configured the AWS CLI yet, this is the first step to complete. Once your credentials are set, you will be able to execute terraform commands that interact directly with your AWS account.
>
> We'll walk through the steps to authenticate using AWS CLI, validate the connection, and then proceed to initialize and apply the Terraform code.

<details>
<summary> <strong>Step 1</strong>: Create a dedicated IAM user for Terraform</summary>

<br />

<table>
<tr>
<td>
To follow security best practices, avoid using the AWS root account or administrator accounts for automation tasks. Instead, create a dedicated IAM user with limited permissions for Terraform.
We'll create this user using the AWS Console (<i>GUI</i>).
</td>
</tr>
</table>

**Instructions**:

> **User creation**

| Capture | <div align="center">Description</div> |
| :-: | :- |
| <img src="https://drive.google.com/uc?id=1YpbmDSfN01a3laY0u77Oq8BaNZe7isA1"> | 1. Go to the AWS Console and navigate to **IAM** <br /> 2. Click **Users** <br /> 3. Create **users** |
| <img src="https://drive.google.com/uc?id=1ygvMzX4X1tPdhVq1PNPsUleYGoaTIh8l"> | 4. Enter a username such as `terraform-challenge`.<br /> 5. Select **Provide user access to the AWS Management Console - optional** to gran console access <br /> 6. Select **I want to create an IAM user** <br /> 7. Set a **Custom password** <br /> 8. Un check **Users must create a new password at next sign-in** <br /> 9. Click **Next** |
| <img src="https://drive.google.com/uc?id=1h2NBfsz4bI6-4DRSUNRWUGTdT9XeGGwr"> | 10. Select **Attach policies directly** |
| <img src="https://drive.google.com/uc?id=1TYV7HHWfz5o55Ery2nYdxRJ9lwAQizfx"> <br /> <img src="https://drive.google.com/uc?id=1msiS3u-dP9_GCumoZMHlxhTMO4bGzNp6"> <br /> <img src="https://drive.google.com/uc?id=1nNrWD39pvhRCCk-BFPMaCbcX4XCWgp__"> <br /> <img src="https://drive.google.com/uc?id=18mrzCibEZGm3Lbuj3lJ1S6_hDNoxHcaB"> <br /> <img src="https://drive.google.com/uc?id=1AzrW1LKWpbpKkX48mV6-pFL2j04VhKCy"> | 11. Attach pre-existing policy `AmazonEC2FullAccess` <br /> 12. Attach pre-existing policy `AmazonS3FullAccess` <br /> 12. Attach pre-existing policy `ElasticLoadBalancingFullAccess` <br /> 13. Attach pre-existing policy `AutoScalingFullAccess` <br /> 14. Attach pre-existing policy `IAMReadOnlyAccess` |
| <img src="https://drive.google.com/uc?id=1CbgQ0AaK9bxLR_VYoiAvUz8CXLhUdWw9"> | 15. Click **Create user** |
| <img src="https://drive.google.com/uc?id=1r27kTryQdTfhxm6TwIvhPyf3sVFR-_me"> | 16. Click **Download .csv file** |

> **Access Key creation**

| Capture | <div align="center">Description</div> |
| :-: | :- |
| <img src="https://drive.google.com/uc?id=1E4wpN4--sj1eDn7XJd_kTxP0HlWxEbG0"> | 1. Navigate to **IAM** <br /> 2. Click **Users** <br /> 3. Click on `terraform-challenge` user. |
| <img src="https://drive.google.com/uc?id=1-8YRP-BcHLK9hmFJfoWnurv9gXPpOR8R"> | 4. Click **Create access key** |
| <img src="https://drive.google.com/uc?id=1e-vDkgfrBw-6U6BYtdEJg3LOHdVcU_fx"> | 5. Click **Command line interface** <br /> 6. Check the **Confirmation** <br /> 7. Click **Next** |
| <img src="https://drive.google.com/uc?id=18CS7coBzgoA8SZOHUF_qxqTW82FuOzA4"> | 8. Click **Create access key** |
| <img src="https://drive.google.com/uc?id=1umv4eGPX5lwgyAW6jxKBYEghglDmA3uE"> | 9. Click **Done** (_important, copy the credentials generated_) |

</details>

<details>
<summary><strong>Step 2</strong>: Configure AWS CLI with the new IAM user's credentials</summary>

<br />

Once the access key and secret access key for your `terraform-challenge` user have been generated and downloaded, you can configure the AWS CLI to use them by running the `aws configure` command. This will store the credentials locally and enable Terraform to authenticate with AWS.

### Instructions

1. Open a terminal or command prompt and run the following command: `aws configure`
1. You will be prompted to enter the following values:
   | <div align="center">Prompt</div> | <div align="center">Example Value</div> |
   | :- | :- |
   | AWS Access Key ID | `AKIAIOSFODNN7EXAMPLE` |
   | AWS Secret Access Key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
   | Default region name | `us-east-1` |
   | Default output format | `json` |
1. After entering this information, the AWS CLI will store the credentials in:
   - ~/.aws/credentials
   - ~/.aws/config

   _If successful, this will return your AWS account and IAM user information._
   <img src="https://drive.google.com/uc?id=1BVFPl81HUluuAKwmtRWRMoNVtpC-MXIS">

</details> 

<hr />

## References to resources used

| Reference | Link | Description |
| - | - | :- |
| Terraform  | [A Beginner’s Guide to Installing Terraform on Windows](<https://medium.com/@morsi.masmoudi/a-beginners-guide-to-installing-terraform-on-windows-9321e566893d>) | _How to install Terraform_ |
| Markdown | [Embedding images in google drive to markdown](https://www.intodeeplearning.com/embedding-images-in-google-drive-to-markdown/) | _How to embed images from google cloud using a shared public image_ |
| GitHub | [Using secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/encrypted-secrets) | How to create and use secrets on a GitHub Action. |
| GitHub | [About protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) |
| AWS | [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) | AWS IAM official best-practises |
| Terraform | [Remote backends](https://developer.hashicorp.com/terraform/language/state/remote) | To store the TF.state in a remote place |
| Mermaid | [Infrastructure Diagram](https://mermaid.live/edit#pako:eNp1km9vmzAQxr-K5VeJlFCDIaRoqkT-jEVKpKhMq1SyFw64BBVs5JilbZLvPmNCUzLNMpKfx_e7O584wpgnFHrwJeeHeEeEBD9nGwbUWjBJBaOy12tP_T4YDh_AIniKWgsERNIDef99YYInHeJHv9ZTYCLDNJCB7szR5d7Xt5NoXW3zLAZhta1zmN-24u7hM9qywRD4z2aHmd4w1pUxr4zVYWbRWmR_VIMthK-Q9b9C81vIvkL430qT5r3LSeSXpeqPyIwzsOQkAROSExZTofk1V6Mdows1bamvcj61IvWpwe9lDWrukSY_iNRHaRlFFguuRTuGtvelbuT0nYsDEckeSA7KuqRt4xPwwyDyK2WFMckzloJA8KrUeVYZA5Z60Yq8gZF2_JLEO9p0kec0aSuEQTPUrpx35Gnhr8Ajz-kJhHhRkJTuo16IwaSKX6n0QKat_iVl_dhbaMnTLpIrowX21TYVpNypuMaoV1voq1NnaTRlCRzAVGQJ9KSo6AAWVBSklvBYh2yg3NGCbqCnjgkRrxu4YWfFlIQ9c160mJpYuoPeC8n3SlVlon6RWUZUP8WnK1Q1Kqa8YhJ6lqNzQO8I36CHHdfA9wgjV-0RGrkD-K7ckaEMEzvmeGwiG7nOeQA_dFVkjF0HqeXcW7aDTYTPfwEBtw6k) | Online tool to create Mermaid diagrams. |

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
